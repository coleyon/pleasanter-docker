**これは何**

オープンソースWebDB [プリザンター](https://github.com/Implem/Implem.Pleasanter) のデモを、簡単に起動できるようシングルコンテナにまとめたComposeです。
[Docker上で動かしてみた公式記事](https://pleasanter.hatenablog.jp/entry/2019/04/08/191954)の構築手順を基にしつつ、
MSSQLとPleasanterが、Supervisorでシングルコンテナ内で同時に起動する構成です。

**Quick Start**

    $ docker-compose build
    $ docker-compose up -d
    $ docker exec -it $CONTAINER_ID cmdnetcore/codedefiner.sh   # 初回DB生成
    <INFO> RdsConfigurator.Configure: Implem.Pleasanter
    <INFO> LoginsConfigurator.Execute: Implem.Pleasanter_Owner
    <INFO> LoginsConfigurator.Execute: Implem.Pleasanter_User
    <INFO> TablesConfigurator.ConfigureTableSet: Tenants
    <INFO> Tables.CreateTable: Tenants
    <INFO> Tables.CreateTable: Tenants_deleted
    <INFO> Tables.CreateTable: Tenants_history
    <INFO> TablesConfigurator.ConfigureTableSet: Demos
    <INFO> Tables.CreateTable: Demos
    ...
    <SUCCESS> Starter.ConfigureDatabase: Database configuration is complete.
    <SUCCESS> Starter.Main: All of the processing has been completed.

access to ``http://localhost`` .

    user: Administrator
    pass: pleasanter
