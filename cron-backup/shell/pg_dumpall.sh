#!/bin/bash

#暗号化パスワード
ZIP_PASSWORD='Vi8PRhxL'

# バックアップファイルを残しておく日数
PERIOD='+90'

# バックアップ先ディレクトリ
SAVEPATH_BASE='/var/db_backup/dumpall'
# 日付
DATE=`date '+%Y%m%d-%H%M%S'`
# 先頭文字
PREFIX='postgres-'
# 拡張子
EXT='.sql'

#バックアップディレクトリ作成
SAVEPATH=$SAVEPATH_BASE/`date '+%Y%m'`/
mkdir -p $SAVEPATH

# バックアップ実行
BACKUP_FILE_NAME=$PREFIX$DATE$EXT
BACKUP_FILE=$SAVEPATH$PREFIX$DATE$EXT
time nice -n 19 pg_dumpall -h postgres-db -p 5432  -U postgres | 7z a -mx=9 -mhe=on -p$ZIP_PASSWORD -si$BACKUP_FILE_NAME $BACKUP_FILE.7z

# 保存期間が過ぎたファイルの削除
find $SAVEPATH_BASE -type f -daystart -mtime $PERIOD -exec rm {} \;

# 空になったディレクトリを消去
find $SAVEPATH_BASE -type d -empty -delete
