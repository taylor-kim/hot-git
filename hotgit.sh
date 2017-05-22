#!/bin/bash

DIR_OF_THIS_SCRIPT="$(cd "$(dirname -- "${BASH_SOURCE}")"; echo "$(pwd)")"
source $DIR_OF_THIS_SCRIPT/config.sh

pull() {
	git branch | grep '*' | awk '{ print $2 }' | xargs git pull origin
}

push() {
	git branch | grep '*' | awk '{ print $2 }' | xargs git push origin
}

new() {
	branch_name=$1
	from=$2

	if [[ $branch_name == "f"* ]];
		then 
			branch_name="${branch_name/f/feature/${TITLE}-}"
	elif [[ $branch_name == "h"* ]];
		then 
			branch_name="${branch_name/h/hotfix/${TITLE}-}"
	else echo "branch name must be start f or h. retry."
		return 0
	fi

	if [[ $from == "d" ]];
		then
			from="${from/d/develop}"
	elif [[ $from == "od" ]];
		then
			from="${from/od/origin/develop}"
	elif [[ $from == "m" ]];
		then
			from="${from/m/master}"
	elif [[ $from == "om" ]];
		then
			from="${from/om/origin/master}"
	elif [[ $from == "f"* ]];
		then
			from="${from/f/feature/${TITLE}-}"
	elif [[ $from == "of"* ]];
		then
			from="${from/of/origin/feature/${TITLE}-}"
	else
		echo "source branch name must be d, od, m or om. retry."
		return 0
	fi

	git checkout -b $branch_name $from
}

checkout() {
	branch_name=$1

	if [[ $branch_name =~ "f" ]];
		then 
			branch_name="${branch_name/f/feature/${TITLE}-}"
	elif [[ $branch_name =~ "h" ]];
		then 
			branch_name="${branch_name/h/hotfix/${TITLE}-}"
	fi

	git checkout $branch_name
}

ap() {
	for project in $REPOS
	do
		printf "===== $project pull develop & master =======\n\n"
		cmd_awk="awk '{ print $2 }'"
		origin_branch=`sh -c "cd $REPOS_HOME/$project && git branch | grep '*'" | awk '{ print $2}'`
		stash_result=`sh -c "cd $REPOS_HOME/$project && git stash"`

		printf "\n$stash_result\n\n"

		sh -c "cd $REPOS_HOME/$project && git checkout develop && git pull origin develop"
		sh -c "cd $REPOS_HOME/$project && git checkout master && git pull origin master"
		sh -c "cd $REPOS_HOME/$project && git checkout $origin_branch"

		if [[ $stash_result != "No local changes"* ]];
			then
				sh -c "cd $REPOS_HOME/$project && git stash pop"
		fi

		printf "\n\n========================================\n\n"
	done
}

add_mod() {
	git status | grep modified | awk '{ print $2}' | xargs git add
}

add_conflicts() {
	git status | grep both | awk '{ print $3}' | xargs git add
}

gb() {
	git branch
}

gba() {
	git branch -a
}

