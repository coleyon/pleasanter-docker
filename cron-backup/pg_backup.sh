#!/bin/bash

#暗号化パスワード
ZIP_PASSWORD='Vi8PRhxL'

# バックアップファイルを残しておく日数
PERIOD='+10'

# バックアップ先ディレクトリ
SAVEPATH_BASE='/var/backup/'
# データーベース名
DBNAME='Implem.Pleasanter'
# 日付
DATE=`date '+%Y%m%d-%H%M%S'`
# 先頭文字
PREFIX='postgres-'
# 拡張子
EXT='.sql'

# 作業用のディレクトリ作成
WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT # 最後に実行されるコマンドを登録

#バックアップディレクトリ作成
SAVEPATH=$SAVEPATH_BASE/`date '+%Y%m'`/
mkdir -p $SAVEPATH

# バックアップ実行
pushd $WORK_DIR
BACKUP_FILE=$SAVEPATH$PREFIX$DATE$EXT
pg_dump -h postgres-db -p 5432  -U postgres  $DBNAME > $BACKUP_FILE
7z a -mx=9 -mhe=on -p$ZIP_PASSWORD $BACKUP_FILE.7z $BACKUP_FILE
rm $BACKUP_FILE
popd

# 保存期間が過ぎたファイルの削除
find $SAVEPATH_BASE -type f -daystart -mtime $PERIOD -exec rm {} \;

