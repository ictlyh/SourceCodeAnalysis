### Source Code Analysis of Impala, PostgreSQL, Citus and Postgres-XL  ###


#### [Impala](http://impala.apache.org/) ####
- [Impala 简介](http://www.mutouxiaogui.cn/blog/?p=319)
- [源码分析 - FE端](http://www.mutouxiaogui.cn/blog/?p=332)
- [源码分析 - BE端](http://www.mutouxiaogui.cn/blog/?p=336)
- [FE 端代码流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/FE%20%E7%AB%AF%E4%BB%A3%E7%A0%81%E6%B5%81%E7%A8%8B.pdf)
- [FE 端主要类继承关系](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/FE%20%E7%AB%AF%E4%B8%BB%E8%A6%81%E7%B1%BB%E7%BB%A7%E6%89%BF%E5%85%B3%E7%B3%BB%E5%9B%BE.pdf)
- [创建删除索引 FE 端流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/%E5%88%9B%E5%BB%BA%E5%88%A0%E9%99%A4%E7%B4%A2%E5%BC%95FE%E7%AB%AF%E5%A4%84%E7%90%86%E6%B5%81%E7%A8%8B.pdf)
- [Planner 查询计划生成](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/Planner%20%E8%AE%A1%E5%88%92%E7%94%9F%E6%88%90.pdf)
- [查询重写](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/StmtRewrite.pdf)
- [用户定义函数动态库文件或Jar包加载](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/udf%20so%20%E5%92%8C%20jar%20%E6%96%87%E4%BB%B6%E5%8A%A0%E8%BD%BD.pdf)
- [数据结构-Thrift部分](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84-Thrift%20%E9%83%A8%E5%88%86.pdf)
- [DataSink](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/DataSink.pdf)
- [ExchangeNode](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/ExchangeNode.pdf)
- [ParseNode 接口及其实现类](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/ParseNode%20%E6%8E%A5%E5%8F%A3%E5%B1%95%E5%BC%80%E7%9A%84%E5%90%84%E7%A7%8D%20Stmt.pdf)
- [Join Internal](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Impala/Join%20Internal.pdf)

#### [PostgreSQL](https://www.postgresql.org/) ####
- [PostgreSQL 源码分析](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/PostgreSQL%20%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90.pdf)
- [查询执行流程](http://www.mutouxiaogui.cn/blog/?p=417)
- [9.6 parallel scan 整体流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/9.6%20parallel%20scan%20%E6%95%B4%E4%BD%93%E6%B5%81%E7%A8%8B.pdf)
- [background worker 注册及启动流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/background%20worker%20%E6%B3%A8%E5%86%8C%E5%8F%8A%E5%90%AF%E5%8A%A8.pdf)
- [配置文件加载流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/config%20options.pdf)
- [create table 流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/create%20table.pdf)
- [共享内存](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/shared%20memory.pdf)
- [共享内存结构图](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/PostgreSQL/%E5%85%B1%E4%BA%AB%E5%86%85%E5%AD%98%E7%BB%93%E6%9E%84%E5%9B%BE.bmp)

#### [Citus](https://www.citusdata.com/) ####
- [Citus 整体流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Citus/citus.mm)
- [copy from 流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Citus/copy%20from.pdf)

#### [Postgres-XL](http://www.postgres-xl.org/) ####
- [通过 alter table 增删 datanode 以及 rebalance](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Postgres-XL/%E9%80%9A%E8%BF%87%20alter%20table%20rebalance.pdf)
- [copy from 流程](https://github.com/ictlyh/SourceCodeAnalysis/blob/master/Postgres-XL/copy%20from.pdf)