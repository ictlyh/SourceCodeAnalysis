<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1463292339935" ID="ID_597132478" MODIFIED="1463292402702" TEXT="citus">
<node CREATED="1463292484888" ID="ID_347558854" MODIFIED="1463643845442" POSITION="right" TEXT="user defined functions">
<node CREATED="1463292488170" ID="ID_1341583664" MODIFIED="1483700266326">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p style="text-align: left">
      master_create_distributed_table
    </p>
    <p style="text-align: left">
      &#26681;&#25454;&#34920;&#21517;&#12289;&#20998;&#21306;&#21015;&#21517;&#21644;&#20998;&#21306;&#26041;&#27861;&#26356;&#26032;&#20803;&#25968;&#25454;
    </p>
  </body>
</html></richcontent>
<node CREATED="1463292575922" ID="ID_1304261140" MODIFIED="1463563815813" TEXT="1. &#x83b7;&#x5f97;&#x8868;&#x7684;handler&#x5e76;&#x68c0;&#x67e5;owner:&#xa;distributedRelation = relation_open(distributedRelationId, AccessExclusiveLock);&#xa;distributedRelationName = RelationGetRelationName(distributedRelation);&#xa;EnsureTableOwner(distributedRelationId);"/>
<node CREATED="1463292614317" ID="ID_1111017517" MODIFIED="1463292680296" TEXT="2. &#x83b7;&#x5f97;&#x8868;pg_dist_partition&#xff0c;&#x4e4b;&#x540e;&#x8981;&#x5f80;&#x8be5;&#x8868;&#x4e2d;&#x586b;&#x5199;&#x4e00;&#x884c;&#x65b0;&#x7684;&#x8bb0;&#x5f55;&#xff1a;&#xa;pgDistPartition = heap_open(DistPartitionRelationId(), RowExclusiveLock);"/>
<node CREATED="1463292682346" ID="ID_244020979" MODIFIED="1463292740171" TEXT="3. &#x5224;&#x65ad;&#x8be5;&#x8868;&#x662f;&#x5426;&#x5df2;&#x7ecf;&#x4e3a;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#xff0c;&#x82e5;&#x662f;&#xff0c;&#x5219;&#x8fd4;&#x56de;&#x9519;&#x8bef;&#xa;if (IsDistributedTable(distributedRelationId)) {...}">
<node CREATED="1463292741855" ID="ID_424430879" MODIFIED="1463563859698" TEXT="&#x5230;cache&#x4e2d;&#x67e5;&#x770b;&#x8be5;&#x8868;&#x7684;&#x4fe1;&#x606f; &#xa; cacheEntry = LookupDistTableCacheEntry(relationId);&#xa;  return cacheEntry-&gt;isDistributedTable;">
<node CREATED="1463292835306" ID="ID_162314858" MODIFIED="1463292932886" TEXT="1. &#x5230;&#x5168;&#x5c40;&#x53d8;&#x91cf;HTAB *DistTableCacheHash&#x4e2d;&#x67e5;&#x770b;&#x8be5;&#x8868;&#x662f;&#x5426;&#x5b58;&#x5728;&#xff1a;&#xa;cacheEntry = hash_search(DistTableCacheHash, hashKey, HASH_FIND, &amp;foundInCache);&#xa;  1.1 &#x5982;&#x679c;hit,&#x4e14;valid&#x5219;&#x8fd4;&#x56de;&#x7f13;&#x5b58;&#x9879;&#xa;  1.2 &#x5982;&#x679c;hit&#x4e14;invalid,  &#x5219;&#x91ca;&#x653e;&#x8be5;&#x5185;&#x5b58; ResetDistTableCacheEntry(cacheEntry);"/>
<node CREATED="1463292934028" ID="ID_1974105813" MODIFIED="1463292951105" TEXT="2. &#x7f13;&#x5b58;&#x6ca1;&#x6709;&#x547d;&#x4e2d;&#xff1a;&#xa;distPartitionTuple = LookupDistPartitionTuple(relationId);">
<node CREATED="1463292977595" ID="ID_1902694869" MODIFIED="1463293063256" TEXT="&#x67e5;&#x770b;&#x8868;pg_dist_partition&#xff0c;&#x662f;&#x5426;&#x6709;&#x8be5;&#x8868;&#x7684;&#x8bb0;&#x5f55;&#xff1a;&#xa;pgDistPartition = heap_open(DistPartitionRelationId(), AccessShareLock);&#xa;scanKey[0].sk_argument = ObjectIdGetDatum(relationId);&#xa;scanDescriptor = systable_beginscan(pgDistPartition,&#xa;                    DistPartitionLogicalRelidIndexId(),&#xa;                    true, NULL, 1, scanKey);&#xa;currentPartitionTuple = systable_getnext(scanDescriptor);&#xa;distPartitionTuple = heap_copytuple(currentPartitionTuple);&#xa;return distPartitionTuple;"/>
</node>
<node CREATED="1463293097363" ID="ID_992145072" MODIFIED="1463293164684" TEXT="3. &#x5982;&#x679c;&#x8868;pg_dist_partition&#x4e2d;&#x6709;&#x8be5;&#x8868;&#x7684;&#x4fe1;&#x606f;&#xff0c;&#x90a3;&#x4e48;&#x4ece;distPartitionTuple&#x4e2d;&#x83b7;&#x5f97;partitionkey&#x548c;method"/>
<node CREATED="1463293187374" ID="ID_275185504" MODIFIED="1463563911118" TEXT="4. &#x4ece;&#x8868;pg_dist_shard&#x4e2d;&#x83b7;&#x5f97;&#x8be5;table&#x7684;&#x5206;&#x7247;&#x4fe1;&#x606f;&#xff1a;&#xa;distShardTupleList = LookupDistShardTuples(relationId);">
<node CREATED="1463293222057" ID="ID_1534267388" MODIFIED="1463293350202" TEXT="pgDistShard = heap_open(DistShardRelationId(), AccessShareLock);&#xa;&#x8bbe;&#x7f6e;&#x8fc7;&#x6ee4;&#x6761;&#x4ef6;&#x5f97;&#x5230;&#x8be5;&#x8868;&#x7684;tuples&#x4fe1;&#x606f;&#xff1a;&#xa;scanKey[0].sk_argument = ObjectIdGetDatum(relationId);&#xa;scanDescriptor = systable_beginscan(pgDistShard, DistShardLogicalRelidIndexId(), true,&#xa;                    NULL, 1, scanKey);&#xa;currentShardTuple = systable_getnext(scanDescriptor);&#xa;&#x628a;&#x7ed3;&#x679c;&#x52a0;&#x5165;&#x5230;list&#x4e2d;&#x5e76;&#x8fd4;&#x56de;&#xff1a;&#xa;distShardTupleList = lappend(distShardTupleList, shardTupleCopy);&#xa;return distShardTupleList;"/>
</node>
<node CREATED="1463293533861" ID="ID_486671318" MODIFIED="1463293666653" TEXT="5. &#x5982;&#x679c;&#x6709;&#x5206;&#x7247;&#x4fe1;&#x606f;&#xff0c;&#x5219;&#x628a;&#x4ed6;&#x4eec;&#x8f6c;&#x4e3a;shardInterval&#x7c7b;&#x578b;&#xff0c;&#x653e;&#x5230;ShardInterval **shardIntervalArray &#x53d8;&#x91cf;&#x4e2d;:&#xa;shardIntervalArray = MemoryContextAllocZero(CacheMemoryContext,&#xa;                          shardIntervalArrayLength *&#xa;                          sizeof(ShardInterval *));&#xa;&#xa;    foreach(distShardTupleCell, distShardTupleList)&#xa;    {&#xa;      ShardInterval *shardInterval = TupleToShardInterval(...)&#xa;      shardIntervalArray[arrayIndex] = newShardInterval;&#xa;     }"/>
<node CREATED="1463293667583" ID="ID_963698815" MODIFIED="1463293685928" TEXT="6. &#x8bbe;&#x7f6e;shard interval&#x5bf9;&#x6bd4;&#x51fd;&#x6570;&#xff1a;&#xa;shardIntervalCompareFunction = ShardIntervalCompareFunction(shardIntervalArray,&#xa;                                  partitionMethod);"/>
<node CREATED="1463293701185" ID="ID_471370096" MODIFIED="1463293722825" TEXT="7. &#x83b7;&#x5f97;&#x6392;&#x5e8f;&#x540e;&#x7684;shardintervalArray:&#xa;sortedShardIntervalArray= SortShardIntervalArray(shardIntervalArray,&#xa;                            shardIntervalArrayLength,&#xa;                            shardIntervalCompareFunction);"/>
<node CREATED="1463293929813" ID="ID_238570464" MODIFIED="1463563957923" TEXT="8. &#x786e;&#x8ba4;&#x5df2;&#x6392;&#x5e8f;&#x7684;shard&#x662f;&#x5426;&#x6709;&#x7edf;&#x4e00;&#x7684;hash&#x5206;&#x5e03;&#xff1a;&#xa;hasUniformHashDistribution =&#xa;      HasUniformHashDistribution(sortedShardIntervalArray,&#xa;                     shardIntervalArrayLength);">
<node CREATED="1463294251141" ID="ID_1021215128" MODIFIED="1463294289965" TEXT="hash&#x7684;&#x8303;&#x56f4;&#x662f;INT32_MIN-INT32_MAX&#xa;&#x6309;&#x7167;&#x5206;&#x7247;&#x4e2a;&#x6570;&#x8fdb;&#x884c;&#x5747;&#x5206;&#x3002;"/>
</node>
<node CREATED="1463293966507" ID="ID_604660743" MODIFIED="1463293997612" TEXT="9. &#x628a;&#x5f53;&#x524d;&#x8fd9;&#x4e2a;cacheEntry&#x8d4b;&#x503c;&#xff0c;&#x5b58;&#x50a8;&#x5230;&#x7f13;&#x5b58;&#x53d8;&#x91cf;DistTableCacheHash&#x4e2d;&#x3002;"/>
</node>
</node>
<node CREATED="1463295047042" ID="ID_1218551202" MODIFIED="1463295102184" TEXT="4. &#x786e;&#x8ba4;&#x8be5;&#x8868;&#x4e3a;regular&#x8868;&#x6216;&#x8005;foreign&#x8868;&#xff1a;&#xff08;&#x53ea;&#x6709;&#x8fd9;&#x4e24;&#x79cd;&#x8868;&#x624d;&#x53ef;&#x4ee5;&#x505a;&#x5206;&#x5e03;&#x5f0f;&#xff09;&#xa;relationKind = distributedRelation-&gt;rd_rel-&gt;relkind;&#xa;&#x8fea;&#x6b27;relationKind&#x505a;&#x5224;&#x65ad;&#x3002;"/>
<node CREATED="1463295317333" ID="ID_575693521" MODIFIED="1463295352099" TEXT="5,&#x5982;&#x679c;&#x662f;hash&#x5206;&#x5e03;&#xff1a;&#xa;Oid hashSupportFunction = SupportFunctionForColumn(distributionColumn,&#xa;                               HASH_AM_OID, HASHPROC);&#xa;if (hashSupportFunction == InvalidOid) {...}"/>
<node CREATED="1463295353348" ID="ID_571203702" MODIFIED="1463295372793" TEXT="6. &#x5982;&#x679c;&#x662f;range&#x5206;&#x5e03;&#xff1a;&#xa;Oid btreeSupportFunction = SupportFunctionForColumn(distributionColumn,&#xa;                              BTREE_AM_OID, BTORDER_PROC);"/>
<node CREATED="1463295465740" ID="ID_46556708" MODIFIED="1463295705366" TEXT="7. &#x83b7;&#x5f97;&#x8be5;&#x8868;&#x7684;&#x6240;&#x6709;indices, &#x904d;&#x5386;&#x6bcf;&#x4e2a;index,&#x67e5;&#x770b;&#x662f;&#x5426;unique, primary key&#x7b49;&#x9650;&#x5236;&#xff0c;&#xa;&#x5224;&#x65ad;&#x662f;&#x5426;&#x4e0e;&#x8868;&#x7684;&#x5217;&#x53ca;&#x5bf9;&#x5e94;&#x5206;&#x5e03;&#x5f0f;&#x65b9;&#x6cd5;&#x51b2;&#x7a81;&#x3002;&#xa;indexOidList = RelationGetIndexList(distributedRelation);&#xa;foreach(indexOidCell, indexOidList)&#xa;{&#xa;  ...&#xa;  &#x4ece;pg_index&#x4e2d;&#x89e3;&#x6790;&#x51fa; index key&#x5bf9;&#x5e94;&#x7684;&#x4fe1;&#x606f;&#xa;  indexInfo = BuildIndexInfo(indexDesc);&#xa;  ...&#xa;}"/>
<node CREATED="1463295706364" ID="ID_312552144" MODIFIED="1463295830902" TEXT="8. &#x4e3a;&#x8be5;&#x8868;&#x6784;&#x5efa;&#x65b0;&#x7684;&#x8bb0;&#x5f55;&#x63d2;&#x5165;&#x5230;pg_dist_partition&#x8868;&#x4e2d;&#x5e76;&#x66f4;&#x65b0;index,&#x53ca;cache&#xa;simple_heap_insert(pgDistPartition, newTuple);&#xa;CatalogUpdateIndexes(pgDistPartition, newTuple);&#xa;CitusInvalidateRelcacheByRelid(distributedRelationId);&#xa;RecordDistributedRelationDependencies(distributedRelationId, distributionKey);"/>
</node>
<node CREATED="1463643850823" ID="ID_1571820446" MODIFIED="1463644086701">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p>
      master_create_worker_shards
    </p>
    <p>
      &#26681;&#25454;&#25351;&#23450;&#20998;&#29255;&#25968;&#30446;&#20026;&#25351;&#23450;&#34920;&#21019;&#24314;&#31354;&#20998;&#29255;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1463643869443" ID="ID_1065653879" MODIFIED="1463643878910" TEXT="master_create_empty_shard"/>
<node CREATED="1463643879791" ID="ID_1920103836" MODIFIED="1463643894486" TEXT="master_append_table_to_shard"/>
<node CREATED="1463643895054" ID="ID_1650303675" MODIFIED="1463643907958" TEXT="master_apply_delete_command"/>
<node CREATED="1463643908411" ID="ID_1316302874" MODIFIED="1463643924347" TEXT="master_get_active_worker_nodes"/>
<node CREATED="1463643924628" ID="ID_61447538" MODIFIED="1463643934812" TEXT="master_get_table_metadata"/>
<node CREATED="1463643935153" ID="ID_418441642" MODIFIED="1463643948236" TEXT="master_copy_shard_placement"/>
<node CREATED="1463643949096" ID="ID_523969005" MODIFIED="1463712867460">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p style="text-align: left">
      rebalance_table_shards
    </p>
    <p style="text-align: left">
      &#20225;&#19994;&#29256;&#25165;&#26377;&#30340;&#21151;&#33021;
    </p>
  </body>
</html></richcontent>
</node>
<node CREATED="1463643966205" ID="ID_612526904" MODIFIED="1463649433589">
<richcontent TYPE="NODE"><html>
  <head>
    
  </head>
  <body>
    <p style="text-align: left">
      replicate_table_shards
    </p>
    <p style="text-align: left">
      &#20225;&#19994;&#29256;&#25165;&#26377;&#30340;&#21151;&#33021;
    </p>
  </body>
</html></richcontent>
</node>
</node>
<node CREATED="1463298242967" ID="ID_1600944819" MODIFIED="1463474778556" POSITION="right" TEXT="hook">
<node CREATED="1463298245097" ID="ID_1127049125" MODIFIED="1463622947411" TEXT="&#x5206;&#x5e03;&#x5f0f;planner hook:&#xa;multi_planner&#xa;&#x7406;&#x89e3;&#xff1a;&#xa;1. &#x53ea;&#x6709;select\insert\update\delete&#x624d;&#x6709;&#x53ef;&#x80fd;&#x5206;&#x5e03;&#x5f0f;plan">
<node CREATED="1463298269002" ID="ID_403263305" MODIFIED="1463298301213" TEXT="1.  &#x8c03;&#x7528;&#x6807;&#x51c6;&#x7684;planner:&#xa;result = standard_planner(parse, cursorOptions, boundParams);"/>
<node CREATED="1463298314883" ID="ID_873453111" MODIFIED="1463643046786" TEXT="2.&#x5982;&#x679c;&#x662f;&#x5728;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#x7684;select&#x8bf7;&#x6c42;&#xff0c;&#x5219;&#x521b;&#x5efa;&#x5206;&#x5e03;&#x5f0f;planner:&#xa;  if (NeedsDistributedPlanning(parse))&#xa;  {&#xa;    MultiPlan *physicalPlan = CreatePhysicalPlan(parse);&#xa;    /* store required data into the planned statement */&#xa;    result = MultiQueryContainerNode(result, physicalPlan);&#xa;  }">
<node CREATED="1463298409838" ID="ID_887483573" MODIFIED="1463564149825" TEXT="NeedsDistributedPlanning&#x5c55;&#x5f00;:&#xa;&#x53ea;&#x6709;&#x89e3;&#x6790;&#x51fa;&#x7684;&#x6240;&#x6709;range table entries&#x90fd;&#x662f;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#x624d;&#x4f1a;&#x8fd4;&#x56de; true.">
<node CREATED="1463298414151" ID="ID_1990504506" MODIFIED="1463298435672" TEXT="1. &#x5982;&#x679c;&#x4e0d;&#x662f;select/update/insert/delete, &#x5219;return false;"/>
<node CREATED="1463298463536" ID="ID_1692958784" MODIFIED="1463298672055" TEXT="2. &#x4e3a;&#x7b80;&#x5355;&#x7684;&#x8868;&#x89e3;&#x6790;&#x51fa; range table entry,&#x8fc7;&#x6ee4;&#x6389;&#x975e;RTE_RELATION&#x7c7b;&#x578b;&#x7684;&#x9879;:&#xa;ExtractRangeTableRelationWalker((Node *) queryTree, &amp;rangeTableList);"/>
<node CREATED="1463298712755" ID="ID_1920356907" MODIFIED="1463298811630" TEXT="3. &#x904d;&#x5386;rangeTableList&#xff0c;&#x5224;&#x65ad;&#x6bcf;&#x4e2a;&#x8868;&#x662f;&#x5426;&#x4e3a;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#xa;foreach(rangeTableCell, rangeTableList)&#xa;{  &#xa;Oid relationId = rangeTableEntry-&gt;relid;&#xa;if (IsDistributedTable(relationId))&#xa;   ...&#xa;}"/>
<node CREATED="1463298812703" ID="ID_1143140744" MODIFIED="1463298834186" TEXT="4. &#x5982;&#x679c;&#x65e2;&#x6709;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#x53c8;&#x6709;&#x975e;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#xff0c;&#x5219;&#x8fd4;&#x56de;&#x9519;&#x8bef;"/>
<node CREATED="1463298837281" ID="ID_80274830" MODIFIED="1463298851598" TEXT="5. &#x8fd4;&#x56de; hasDistributedRelation"/>
</node>
<node CREATED="1463298889006" ID="ID_1605010571" MODIFIED="1463467064612" TEXT="CreatePhysicalPlan&#x5c55;&#x5f00;:&#xa;&#x5982;&#x679c;&#x662f;&#x4fee;&#x6539;&#x64cd;&#x4f5c;&#xff0c;&#x5219;&#x76f4;&#x63a5;&#x8fdb;&#x5165;&#x7269;&#x7406;plan&#x9636;&#x6bb5;&#xff0c;&#xa;&#x5982;&#x679c;&#x662f;select&#x5219;&#x8fdb;&#x5165;&#x903b;&#x8f91;plan,optimize,&#x7269;&#x7406;plan&#x4e09;&#x4e2a;&#x9636;&#x6bb5;&#x3002;">
<node CREATED="1463298899681" ID="ID_241306713" MODIFIED="1463564215680" TEXT="1.&#x5982;&#x679c;&#x662f;insert/update/delete&#x6216;&#x8005;&#x662f;hash&#x5206;&#x5e03;&#x5f0f;&#x8868;&#x4e0a;&#x7684;select&#x67e5;&#x8be2;&#xff0c;&#x4e14;&#x5728;&#x5206;&#x5e03;&#x5f0f;&#x5217;&#x4e0a;&#x6709;&#x4e00;&#x4e2a;&#xa;   &#x5339;&#x914d;&#x7684;comparison,&#x4e14;&#x662f;real-time&#x7684;&#x4efb;&#x52a1;&#x6267;&#x884c;&#x5668;&#xff0c;&#x5219;&#x8fd4;&#x56de;true&#x3002;&#xa;bool routerPlannable = MultiRouterPlannableQuery(parseCopy, TaskExecutorType);&#xa;&#x8fd4;&#x56de;true&#x8868;&#x660e;&#x8be5;&#x8bf7;&#x6c42;&#x53ef;&#x4ee5;router palnnabel.">
<node CREATED="1463299284064" ID="ID_370665348" MODIFIED="1463299298452" TEXT="1. &#x5982;&#x679c;&#x662f;insert/update/delete&#x8bf7;&#x6c42;&#xff0c;&#x8fd4;&#x56de;true"/>
<node CREATED="1463299302281" ID="ID_1029635483" MODIFIED="1463299337099" TEXT="2.&#x6267;&#x884c;&#x5230;&#x8fd9;&#x91cc;&#x8bf4;&#x660e;&#x662f;&#x4e2a;select &#x8bf7;&#x6c42;&#xff1a;&#xa;if (taskExecutorType != MULTI_EXECUTOR_REAL_TIME)&#xa;   return false;"/>
<node CREATED="1463299426725" ID="ID_311587081" MODIFIED="1463299621592" TEXT="3. &#x5982;&#x679c;&#x5728;selete &#x6216;where&#x4ece;&#x53e5;&#x4e2d;&#x6709;&#x5b50;&#x67e5;&#x8be2;&#xff0c;&#x6216;&#x8005;...&#xa;   &#x6216;&#x8005;partitionMethod&#x4e0d;&#x662f;hash&#x65b9;&#x6cd5;&#xa;   &#x6216;&#x8005;query&#x89e3;&#x6790;&#x51fa;&#x6765;&#x7684;RET_RELATION&#x7684;range table&#x4e2a;&#x6570;&#x4e0d;&#x4e3a;1&#xa;   &#x6216;&#x8005;...&#xa;   &#x6216;&#x8005;hash&#x5206;&#x5e03;&#x8868;&#x7684;&#x5206;&#x7247;&#x4e2a;&#x6570;&#x4e3a;0&#xff1a;&#xa;return false"/>
<node CREATED="1463299622354" ID="ID_317983953" MODIFIED="1463299629031" TEXT="4. return true"/>
</node>
<node CREATED="1463299009755" ID="ID_1395329137" MODIFIED="1463564231829" TEXT="2. &#x5982;&#x679c;routerPlannable&#x6210;&#x7acb;,&#x76f4;&#x63a5;&#x8fdb;&#x5165;physical plan&#x9636;&#x6bb5;&#xff1a;&#xa;physicalPlan = MultiRouterPlanCreate(parseCopy);&#xa;CheckNodeIsDumpable((Node *) physicalPlan);">
<node CREATED="1463300336702" ID="ID_750122224" MODIFIED="1476346877302" TEXT="2.1 &#x5982;&#x679c;&#x662f;insert/delete/update:&#xa;   ErrorIfModifyQueryNotSupported(query);&#xa;   task = RouterModifyTask(query);[&#x5c55;&#x5f00;]">
<node CREATED="1463300602610" ID="ID_32260164" MODIFIED="1483700266350" TEXT="1. &#x83b7;&#x5f97;&#x5f53;&#x524d;&#x8bf7;&#x6c42;&#x6240;&#x5728;&#x7684;&#x5206;&#x7247;&#xff08;&#x53ea;&#x51c6;&#x5bf9;&#x5e94;&#x4e00;&#x4e2a;shard&#xff09;:&#xa;ShardInterval *shardInterval = TargetShardInterval(query);">
<node CREATED="1463300671943" ID="ID_1885652703" MODIFIED="1463300703301" TEXT="1. &#x5f97;&#x5230;query&#x4e2d;&#x7b2c;&#x4e00;&#x4e2a;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#x7684;cache entry:&#xa;Oid distributedTableId = ExtractFirstDistributedTableId(query);&#xa;DistTableCacheEntry *cacheEntry = DistributedTableCacheEntry(distributedTableId);"/>
<node CREATED="1463300703863" ID="ID_1250369434" MODIFIED="1463300732158" TEXT="2. &#x5982;&#x679c;&#x8be5;&#x5206;&#x5e03;&#x5f0f;&#x8868;&#x7684;&#x5206;&#x7247;&#x4e2a;&#x6570;cacheEntry-&gt;shardIntervalArrayLength;&#x4e3a;0&#xff0c;&#x5219;&#x8fd4;&#x56de;&#x9519;&#x8bef;"/>
<node CREATED="1463300738911" ID="ID_742686368" MODIFIED="1463301053387" TEXT="3.&#x5224;&#x65ad;&#x662f;&#x5426;&#x80fd;&#x526a;&#x679d;(&#x5728;hash/range &#x5206;&#x5e03;&#x5f0f;&#x8868;&#x4e0a;&#x505a;insert,   &#x8fd4;&#x56de;true, &#x5426;&#x5219;&#x8fd4;&#x56de;false)&#xff1a;&#xa;fastShardPruningPossible = FastShardPruningPossible(query-&gt;commandType,&#xa;                            partitionMethod);"/>
<node CREATED="1463300786964" ID="ID_1810993459" MODIFIED="1463300905184" TEXT="4. &#x5982;&#x679c;&#x53ef;&#x4ee5;&#x526a;&#x679d;&#xff1a;&#xa;  4.1 Var *partitionColumn = PartitionColumn(distributedTableId, rangeTableId);&#xa;  4.2    Const *partitionValue = ExtractInsertPartitionValue(query, partitionColumn);&#xa;  4.3     ShardInterval *shardInterval = FastShardPruning(distributedTableId,&#xa;                            partitionValue);&#xa;  4.4 &#x628a;&#x7ed3;&#x679c;&#x653e;&#x5230;prunedShardList &#x4e2d;&#x4f5c;&#x4e3a;&#x6700;&#x540e;&#x7684;&#x7ed3;&#x679c;&#xff1a;&#xa;        prunedShardList = lappend(prunedShardList, shardInterval);">
<node CREATED="1463301267383" ID="ID_658012313" MODIFIED="1463301492192" TEXT="  // &#x8c03;&#x7528;FindShardInterval &#x627e;&#x5230;&#x5bf9;&#x5e94;&#x7684;  shard interval &#xa;  shardInterval = FindShardInterval(partitionValue-&gt;constvalue,&#xa;                    sortedShardIntervalArray, shardCount,&#xa;                    partitionMethod,&#xa;                    shardIntervalCompareFunction, hashFunction,&#xa;                    useBinarySearch);"/>
</node>
<node CREATED="1463300905966" ID="ID_1700738166" MODIFIED="1463300946570" TEXT="5.&#x5982;&#x679c;&#x4e0d;&#x53ef;&#x4ee5;&#x526a;&#x679d;&#xff1a;&#xa;  5.1 List *shardIntervalList = LoadShardIntervalList(distributedTableId);&#xa;  5.2 prunedShardList = PruneShardList(distributedTableId, tableId, restrictClauseList,&#xa;                     shardIntervalList);"/>
<node CREATED="1463300948680" ID="ID_1670943697" MODIFIED="1463300987398" TEXT="6. &#x5982;&#x679c;&#x6700;&#x540e;&#x5339;&#x914d;&#x7684;&#x5206;&#x7247;&#x4e2a;&#x6570;list_length(prunedShardList)&#x4e0d;&#x4e3a;1&#xff0c;&#x5219;&#x51fa;&#x9519;"/>
<node CREATED="1463300988606" ID="ID_1563647620" MODIFIED="1463300995288" TEXT="7.   return (ShardInterval *) linitial(prunedShardList);"/>
</node>
<node CREATED="1463301552573" ID="ID_1442805166" MODIFIED="1463301586425" TEXT="2. &#x5bf9;shard&#x5143;&#x6570;&#x636e;&#x52a0;&#x9501;&#x4ee5;&#x514d;&#x5e76;&#x53d1;&#x4efb;&#x52a1;&#x51fa;&#x73b0;&#xff1a;&#xa;LockShardDistributionMetadata(shardId, ShareLock);"/>
<node CREATED="1463455583807" ID="ID_448287787" MODIFIED="1463455610206" TEXT="3. &#x91cd;&#x65b0;&#x6784;&#x9020;&#x8bf7;&#x6c42;&#xff1a;&#x5305;&#x62ec;&#x66ff;&#x6362;&#x8868;&#x540d;&#x4e3a;&#x8868;+shardid:&#xa;deparse_shard_query(query, shardInterval-&gt;relationId, shardId, queryString)"/>
<node CREATED="1463301802253" ID="ID_343933974" MODIFIED="1463455614943" TEXT="4.modifyTask = CitusMakeNode(Task);&#xa;   &#x5bf9;modifyTask&#x8d4b;&#x503c;:&#xa;  modifyTask-&gt;jobId = INVALID_JOB_ID;&#xa;  modifyTask-&gt;taskId = INVALID_TASK_ID;&#xa;  modifyTask-&gt;taskType = MODIFY_TASK;&#xa;  modifyTask-&gt;queryString = queryString-&gt;data;&#xa;  modifyTask-&gt;anchorShardId = shardId;&#xa;  modifyTask-&gt;dependedTaskList = NIL;&#xa;  modifyTask-&gt;upsertQuery = upsertQuery;&#xa;   return modifyTask;"/>
</node>
<node CREATED="1463300397153" ID="ID_614433598" MODIFIED="1483700266357" TEXT="2.2 &#x5426;&#x5219;&#x662f;select(&#x8fd9;&#x662f;router select&#xff0c;&#xa;&#x4e5f;&#x53ea;&#x80fd;&#x5bf9;&#x5e94;&#x4e00;&#x4e2a;shard,&#x5426;&#x5219;&#x62a5;&#x9519;):&#xa;task = RouterSelectTask(query);">
<node CREATED="1463301877546" ID="ID_546389563" MODIFIED="1463301879810" TEXT="1. ShardInterval *shardInterval = TargetShardInterval(query);"/>
<node CREATED="1463301881581" ID="ID_560787455" MODIFIED="1463455756781" TEXT="2.task = CitusMakeNode(Task);&#xa;   task&#x8d4b;&#x503c;:&#xa;  task-&gt;jobId = INVALID_JOB_ID;&#xa;  task-&gt;taskId = INVALID_TASK_ID;&#xa;  task-&gt;taskType = ROUTER_TASK;&#xa;  task-&gt;queryString = queryString-&gt;data;&#xa;  task-&gt;anchorShardId = shardId;&#xa;  task-&gt;dependedTaskList = NIL;&#xa;  task-&gt;upsertQuery = upsertQuery;&#xa;   return task;"/>
</node>
<node CREATED="1463300421174" ID="ID_390192747" MODIFIED="1483700266405" TEXT="2.3 &#x6784;&#x5efa;&#x65b0;&#x7684;job, &#x653e;&#x5230; multiPlan&#x4e2d;&#x6267;&#x884c;&#xff1a;&#xa;  job = RouterQueryJob(query, task);">
<node CREATED="1463455925612" ID="ID_1774088393" MODIFIED="1463455939147" TEXT="1.&#x5982;&#x679c;&#x662f;modify_task:&#xa;taskList = FirstReplicaAssignTaskList(list_make1(task));">
<node CREATED="1463466105860" ID="ID_347716047" MODIFIED="1463467007524" TEXT="1. taskList = ReorderAndAssignTaskList(taskList, reorderFunction);">
<node CREATED="1463466256714" ID="ID_892889047" MODIFIED="1463466271280" TEXT="1.&#x5bf9;taskList&#x8fdb;&#x884c;&#x6392;&#x5e8f;&#xff1a;&#xa;taskList = SortList(taskList, CompareTasksByShardId);"/>
<node CREATED="1463466271907" ID="ID_582344156" MODIFIED="1463466436790" TEXT="2.  &#x5f97;&#x5230;taskList&#x4e2d;&#x6bcf;&#x4e2a;task&#x7684;shardid&#x7684;placement:&#xa;activeShardPlacementLists = ActiveShardPlacementLists(taskList);&#xa;&#x518d;&#x904d;&#x5386;&#x6bcf;&#x4e2a;task&#x7684;activeShardPlacement&#xff0c;&#x5bf9;placeList&#x8fdb;&#x884c;&#x6392;&#x5e8f;&#xff0c;&#xa;&#x518d;&#x8d4b;&#x503c;&#x7ed9;task:task-&gt;taskPlacementList = placementList;">
<node CREATED="1463466473295" ID="ID_1155963520" MODIFIED="1483700266410" TEXT="1. &#x904d;&#x5386;tasklist&#x4e2d;&#x7684;&#x6bcf;&#x4e2a;task:&#xa;   1.1 List *shardPlacementList = FinalizedShardPlacementList(anchorShardId)  ;">
<node CREATED="1463466594200" ID="ID_56014618" MODIFIED="1483700266414" TEXT="List *shardPlacementList = ShardPlacementList(shardId);">
<node CREATED="1463466615523" ID="ID_1563575647" MODIFIED="1463466646288" TEXT="&#x5230;&#x8868;pg_dist_shard_placement&#x4e2d;&#x83b7;&#x5f97;&#x5bf9;&#x5e94;shardid&#x7684;tuples."/>
</node>
</node>
<node CREATED="1463466521362" ID="ID_1275350381" MODIFIED="1463466549894" TEXT="1.2 &#x8fc7;&#x6ee4;&#x6389;inactive node&#x4e0a;&#x7684;shard placements:&#xa;List *activeShardPlacementList = ActivePlacementList(shardPlacementList);"/>
<node CREATED="1463466554487" ID="ID_683220528" MODIFIED="1463466589558" TEXT="1.3  &#x5bf9;activeShardPlacementList&#x8fdb;&#x884c;&#x6392;&#x5e8f;&#xff1a;&#xa;activeShardPlacementList= SortList(activeShardPlacementList,&#xa;    CompareShardPlacements);&#xa;&#x8fd4;&#x56de;&#x7ed3;&#x679c;&#xff1a;return shardPlacementLists;"/>
</node>
<node CREATED="1463466437757" ID="ID_1373319666" MODIFIED="1463466452982" TEXT="3.  &#x8fd4;&#x56de;&#x5df2;&#x7ecf;&#x5206;&#x914d;shardplacement&#x7684;tasklist:&#xa;return assignedTaskList;"/>
</node>
</node>
<node CREATED="1463455940191" ID="ID_632980783" MODIFIED="1463455962049" TEXT="2. &#x5426;&#x5219;&#x662f;select task:&#xa;taskList = AssignAnchorShardTaskList(list_make1(task));">
<node CREATED="1463456252063" ID="ID_751157345" MODIFIED="1463456356916" TEXT="1. &#x5982;&#x679c;&#x4efb;&#x52a1;&#x5206;&#x914d;&#x7b56;&#x7565;&#x662f;TASK_ASSIGNMENT_GREEDY&#xff08;&#x8fd9;&#x662f;&#x9ed8;&#x8ba4;&#x7684;&#xff09;&#xff1a;&#xa;  if(TaskAssignmentPolicy == TASK_ASSIGNMENT_GREEDY)&#xff1a;&#xa;       assignedTaskList = GreedyAssignTaskList(taskList);"/>
<node CREATED="1463456280630" ID="ID_1750911944" MODIFIED="1463456300207" TEXT="2. &#x4efb;&#x52a1;&#x5206;&#x914d;&#x7b56;&#x7565;&#x662f;TASK_ASSIGNMENT_FIRST_REPLICA&#xff1a;&#xa;assignedTaskList = FirstReplicaAssignTaskList(taskList);"/>
<node CREATED="1463456300705" ID="ID_245857134" MODIFIED="1463456316604" TEXT="3.&#x4efb;&#x52a1;&#x5206;&#x914d;&#x7b56;&#x7565;&#x662f;TASK_ASSIGNMENT_ROUND_ROBIN&#xff1a;&#xa;assignedTaskList = RoundRobinAssignTaskList(taskList);"/>
<node CREATED="1463456317094" ID="ID_573658498" MODIFIED="1463456332775" TEXT="4. &#x8fd4;&#x56de;&#x7ed3;&#x679c;&#xff1a;&#xa;return assignedTaskList;"/>
</node>
<node CREATED="1463455970209" ID="ID_872851714" MODIFIED="1463455980553" TEXT="3. &#x6784;&#x5efa;job&#x8fd4;&#x56de;&#xff1a;&#xa;  job = CitusMakeNode(Job);&#xa;  job-&gt;dependedJobList = NIL;&#xa;  job-&gt;jobId = INVALID_JOB_ID;&#xa;  job-&gt;subqueryPushdown = false;&#xa;  job-&gt;jobQuery = query;&#xa;  job-&gt;taskList = taskList;&#xa;&#xa;  return job;"/>
</node>
<node CREATED="1463455886025" ID="ID_689431114" MODIFIED="1463455911882" TEXT="2.4&#x6784;&#x5efa;multiPlan:&#xa;  multiPlan = CitusMakeNode(MultiPlan);&#xa;  multiPlan-&gt;workerJob = job;&#xa;  multiPlan-&gt;masterQuery = NULL;&#xa;  multiPlan-&gt;masterTableName = NULL;&#xa;&#xa;return multiPlan;"/>
</node>
<node CREATED="1463299051457" ID="ID_1595679613" MODIFIED="1483700266453" TEXT="3. &#x5982;&#x679c;routerPlannable&#x4e3a;false:&#xa;&#x5219;&#x8981;&#x7ecf;&#x5386;logival plan, optimize, physical plan&#x4e09;&#x4e2a;&#x9636;&#x6bb5;">
<node CREATED="1463299074758" ID="ID_672430362" MODIFIED="1463557275899" TEXT="1. MultiTreeRoot *logicalPlan = MultiLogicalPlanCreate(parseCopy);&#xa;">
<node CREATED="1463467401292" ID="ID_419459594" MODIFIED="1463467411973" TEXT="1. &#x83b7;&#x5f97;&#x5b50;&#x67e5;&#x8be2;&#x9879;&#xff1a;&#xa;List *subqueryEntryList = SubqueryEntryList(queryTree);"/>
<node CREATED="1463467412438" ID="ID_77108052" MODIFIED="1463467454210" TEXT="2. &#x5982;&#x679c;&#x6709;&#x5b50;&#x67e5;&#x8be2;&#x4e14;&#x5b50;&#x67e5;&#x8be2;&#x8bbe;&#x7f6e;&#x4e0b;&#x63a8;&#x4e86;&#x7684;&#x8bdd;&#xff1a;&#xa;multiQueryNode = SubqueryPushdownMultiPlanTree(queryTree, subqueryEntryList);"/>
<node CREATED="1463467455848" ID="ID_31618909" MODIFIED="1463467496241" TEXT="3. &#x6ca1;&#x6709;&#x5b50;&#x67e5;&#x8be2;&#xff0c;&#x6216;&#x8005;&#x6709;&#x5b50;&#x67e5;&#x8be2;&#x4f46;&#x662f;&#x4e0d;&#x4e0b;&#x63a8;&#xff08;&#x6ca1;&#x6709;join&#xff09;:&#xa;multiQueryNode = MultiPlanTree(queryTree);"/>
<node CREATED="1463467498051" ID="ID_1840007082" MODIFIED="1463467530358" TEXT="4. &#x65b0;&#x589e;&#x52a0;&#x4e00;&#x4e2a;root node&#xff1a;&#xa;  rootNode = CitusMakeNode(MultiTreeRoot);&#xa;  SetChild((MultiUnaryNode *) rootNode, multiQueryNode);&#xa;  return rootNode;"/>
</node>
<node CREATED="1463299080550" ID="ID_1871436828" MODIFIED="1463299088892" TEXT="2. MultiLogicalPlanOptimize(logicalPlan);"/>
<node CREATED="1463299094242" ID="ID_1592600313" MODIFIED="1463299102270" TEXT="3. CheckNodeIsDumpable((Node *) logicalPlan);"/>
<node CREATED="1463299102862" ID="ID_992866519" MODIFIED="1463557368865" TEXT="4. &#x521b;&#x5efa;physical plan&#xff0c;&#x5305;&#x62ec;worker node&#x4e0a;&#x6267;&#x884c;&#x7684;task list&#xa;&#x4ee5;&#x53ca;master node&#x4e0a;&#x6267;&#x884c;&#x7684;final query:&#xa;physicalPlan = MultiPhysicalPlanCreate(logicalPlan);">
<icon BUILTIN="help"/>
<node CREATED="1463469621116" ID="ID_454965871" MODIFIED="1463469910665" TEXT="1. &#x4ece;logical plan tree&#x4e0a;&#x6784;&#x5efa;physical job tree&#xff0c;&#xa;&#x5e76;&#x786e;&#x4fdd;&#x5728;plantree&#x4e2d;&#x53ea;&#x6709;&#x4e00;&#x4e2a;top level worker job:&#xa;workerJob = BuildJobTree(multiTree);"/>
<node CREATED="1463469662671" ID="ID_730505763" MODIFIED="1463557380432" TEXT="2.&#x521b;&#x5efa;&#x5728;worker&#x4e0a;&#x6267;&#x884c;&#x7684;tasks tree:&#xa;workerJob = BuildJobTreeTaskList(workerJob);">
<icon BUILTIN="info"/>
<icon BUILTIN="info"/>
<icon BUILTIN="info"/>
</node>
<node CREATED="1463469784148" ID="ID_626920739" MODIFIED="1463469803779" TEXT="3. &#x5f97;&#x5230;job schem name&#x91cc;&#x9762;&#x6709;master&#x4e0a;&#x6267;&#x884c;&#x7684;&#x8868;&#x540d;&#xff1a;&#xa;jobSchemaName = JobSchemaName(workerJobId);"/>
<node CREATED="1463469715124" ID="ID_1367795721" MODIFIED="1463469808486" TEXT="4. &#x6784;&#x5efa;&#x5728;master&#x4e0a;&#x6267;&#x884c;&#x7684;merge query:&#xa;masterDependedJobList = list_make1(workerJob);&#xa;masterQuery = BuildJobQuery((MultiNode *) multiTree, masterDependedJobList);"/>
<node CREATED="1463469749022" ID="ID_569164444" MODIFIED="1463469812192" TEXT="5. &#x6700;&#x7ec8;&#x7684;plan:&#xa;  multiPlan = CitusMakeNode(MultiPlan);&#xa;  multiPlan-&gt;workerJob = workerJob;&#xa;  multiPlan-&gt;masterQuery = masterQuery;&#xa;  multiPlan-&gt;masterTableName = jobSchemaName-&gt;data;&#xa;&#xa;  return multiPlan;"/>
</node>
</node>
<node CREATED="1463299144128" ID="ID_1676797944" MODIFIED="1463299145926" TEXT="4.return physicalPlan;"/>
</node>
<node CREATED="1463453673258" ID="ID_1369298168" MODIFIED="1463453879406" TEXT="MultiQueryContainerNode&#x5c55;&#x5f00;&#xff1a;&#xa;&#x5b58;&#x50a8;&#x4e00;&#x4e9b;&#x5fc5;&#x8981;&#x7684;&#x6570;&#x636e;&#x5230;palnnedstatment&#x4e2d;&#x3002;&#xa;&#x5176;&#x5b9e;&#x662f;&#x66ff;&#x6362;&#x4e86;result-&gt;planTree=(Plan *) fauxFunctionScan;"/>
</node>
<node CREATED="1463298356084" ID="ID_874814744" MODIFIED="1463298369352" TEXT="3.&#x8fd4;&#x56de;&#x7ed3;&#x679c;&#xa;return result;"/>
</node>
<node CREATED="1463449461572" ID="ID_974707840" MODIFIED="1463564677240" TEXT="&#x5206;&#x5e03;&#x5f0f;executor&#xa;multi_ExecutorStart">
<node CREATED="1463449599866" ID="ID_1005050837" MODIFIED="1463449616799" TEXT="1.&#x5f97;&#x5230;plannedStmt:&#xa;PlannedStmt *planStatement = queryDesc-&gt;plannedstmt;"/>
<node CREATED="1463449617992" ID="ID_387592001" MODIFIED="1463449671846" TEXT="2.&#x5224;&#x65ad;&#x662f;&#x5426;&#x9700;&#x8981;&#x5206;&#x5e03;&#x5f0f;executor:&#xa;  &#x4e24;&#x70b9;&#xff1a;&#x662f;&#x5426;&#x8bbe;&#x7f6e;&#x4e86;citus&#x6269;&#x5c55;&#xff0c;&#x662f;&#x5426;&#x4e3a;&#x5206;&#x5e03;&#x5f0f;plan:&#xa;HasCitusToplevelNode(planStatement)"/>
<node CREATED="1463449676593" ID="ID_1729865642" MODIFIED="1463449719262" TEXT="3. &#x5982;&#x679c;&#x4e0d;&#x9700;&#x8981;&#x5219;&#x6267;&#x884c;Postgres&#x6807;&#x51c6;&#x7684;executor&#xff1a;&#xa;standard_ExecutorStart(queryDesc, eflags);&#x8fd4;&#x56de;"/>
<node CREATED="1463449719948" ID="ID_1504521991" MODIFIED="1463449790520" TEXT="4. &#x82e5;&#x9700;&#x8981;&#x6267;&#x884c;&#x5206;&#x5e03;&#x5f0f;executor:&#xa;   4.1 &#x83b7;&#x5f97;multiPlan(&#x8fd9;&#x4e5f;&#x662f;&#x4e00;&#x4e2a;hook)&#xa;        MultiPlan *multiPlan = GetMultiPlan(planStatement);"/>
<node CREATED="1463450061829" ID="ID_924008449" MODIFIED="1463624270773" TEXT="4.2 ExecCheckRTPerms(planStatement-&gt;rtable, true);"/>
<node CREATED="1463450067596" ID="ID_1914561323" MODIFIED="1463625454731" TEXT="4.3 &#x83b7;&#x5f97;executor type: &#x4f1a;&#x505a;executor&#x7c7b;&#x578b;&#x7684;&#x8c03;&#x6574;&#xff1a;&#xa;&#x6709;&#x53ef;&#x80fd;&#x628a;real-time executor&#x7684;select( task&#x53ea;&#x6709;&#x4e00;&#x4e2a;)&#x67e5;&#x8be2;&#x8f6c;&#x4e3a;router&#xa;executorType = JobExecutorType(multiPlan);">
<icon BUILTIN="info"/>
<icon BUILTIN="info"/>
<icon BUILTIN="info"/>
<icon BUILTIN="info"/>
<node CREATED="1463474950031" ID="ID_1781921977" MODIFIED="1463475445328" TEXT="1. &#x5224;&#x65ad;&#x8be5;multi-plan&#x662f;&#x5426;&#x53ef;&#x4ee5;&#x7528;router executor:&#xa;bool routerExecutablePlan = RouterExecutablePlan(multiPlan, executorType);">
<node CREATED="1463475471082" ID="ID_1568539469" MODIFIED="1463475558995" TEXT="1. task&#x4e2a;&#x6570;&#x5fc5;&#x987b;&#x4e3a;1&#x4e2a;&#x3002;&#xa;&#x56e0;&#x4e3a;router&#x6267;&#x884c;&#x5668;&#x7684;&#x542b;&#x4e49;&#x5c31;&#x662f;&#x8f6c;&#x53d1;&#x8bf7;&#x6c42;&#x5230;&#x4e00;&#x4e2a;workernode&#x4e0a;&#xff0c;&#xa;&#x83b7;&#x5f97;&#x7ed3;&#x679c;&#x5c31;&#x76f4;&#x63a5;&#x8fd4;&#x56de;&#x7ed9;&#x7528;&#x6237;&#x4e86;&#xff0c;&#x4e0d;&#x9700;&#x8981;master node&#x4e0a;&#x518d;&#xa;&#x505a;&#x7ed3;&#x679c;&#x7684;merge&#x7b49;&#x3002;&#x56e0;&#x6b64;&#xff0c;task&#x4e2a;&#x6570;&#x5fc5;&#x987b;&#x4e3a;1&#x624d;&#x6709;&#x53ef;&#x80fd;&#x4f7f;&#x7528;router executor&#x3002;"/>
<node CREATED="1463475568707" ID="ID_878141284" MODIFIED="1463475590656" TEXT="2. &#x662f;modifyTask&#x6216;&#x8005;&#x5df2;&#x7ecf;&#x8bbe;&#x7f6e;&#x4e3a;ROUTER_TASK, return true"/>
<node CREATED="1463475600533" ID="ID_1611486741" MODIFIED="1463475639644" TEXT="3.&#x5df2;&#x7ecf;&#x8bbe;&#x7f6e;&#x4e86;MULTI_EXECUTOR_TASK_TRACKER&#x6216;&#x8005;&#x8be5;job&#x662f;&#x4e2a;repartiton job:&#xa;dependedJobCount &gt;0 &#xa;&#x5219;return false;"/>
<node CREATED="1463475704226" ID="ID_1087470415" MODIFIED="1463475736838" TEXT="4.masterQuery&#x4e0d;&#x80fd;&#x6709;sort&#x4ece;&#x53e5;&#x6216;&#x8005;&#x805a;&#x5408;&#x64cd;&#x4f5c;&#xff0c;&#xa;&#x6709;&#x7684;&#x8bdd; return false;"/>
</node>
<node CREATED="1463474984054" ID="ID_744524918" MODIFIED="1463475006008" TEXT="2. &#x5982;&#x679c;routerExecutablePlan&#x4e3a;&#x771f;&#xff0c;&#x5219;&#xa;return MULTI_EXECUTOR_ROUTER;"/>
<node CREATED="1463475016312" ID="ID_866435062" MODIFIED="1463475211494" TEXT="3.&#x5982;&#x679c;executorType == MULTI_EXECUTOR_REAL_TIME&#xff1a;&#xa;   3.1   &#x5982;&#x679c;&#x5206;&#x914d;&#x7ed9;&#x6bcf;&#x4e2a;worknode&#x7684;task&#x4e2a;&#x6570;&#xa;&#x9;tasksPerNode &gt;= MaxConnections&#xa;&#x9;taskCount &gt;= reasonableConnectionCount&#xff1a;&#xa;&#x9;&#x5219;&#x53d1;&#x51fa;&#x8b66;&#x544a;&#xff1a;&#x8c03;&#x5927;max_connection&#x6216;&#x8bbe;&#x7f6e;&#x6267;&#x884c;&#x5668;&#x4e3a;tracker executor&#xa;   &#x9;&#x6216;&#x8005;&#x8c03;&#x5927;max_files_per_process&#xa;   3.2 &#x5982;&#x679c;&#x6709;dependedJobCount &gt; 0&#xff0c; &#x8868;&#x660e;job&#x88ab;repartition&#x4e86;&#xff0c;&#x62a5;&#x9519;&#xa;&#x9;&#x4e0d;&#x5141;&#x8bb8;&#x5bf9;repartitonJob&#x7528;realtime executor&#xff01;&#xff01;&#xff01;"/>
<node CREATED="1463475225611" ID="ID_122710953" MODIFIED="1463475264743" TEXT="4. &#x5982;&#x679c;executorType=TRACKER_EXECUTOR:&#xa;&#x5982;&#x679c;tasksPerNode &gt;= MaxTrackedTasksPerNode&#x5219;&#x53d1;&#x51fa;&#x8b66;&#x544a;"/>
<node CREATED="1463475265649" ID="ID_530450583" MODIFIED="1463475273597" TEXT="5. return executorType;"/>
</node>
<node CREATED="1463450108906" ID="ID_389217451" MODIFIED="1463625493515" TEXT="4.4 &#x5982;&#x679c;(executorType == MULTI_EXECUTOR_ROUTER)&#xff1a;&#xa;&#x90a3;&#x8868;&#x660e;&#x8fd9;&#x6b21;&#x6267;&#x884c;&#x53ea;&#x6709;&#x4e00;&#x4e2a;task&#x5e76;&#x4e14;&#x6ca1;&#x6709;dependendJobList.">
<node CREATED="1463450191516" ID="ID_545472743" MODIFIED="1463450216928" TEXT="4.4.1  &#x5f97;&#x5230;&#x8fd4;&#x56de;&#x7ed3;&#x679c;&#x7684;tupleDesc:&#xa; TupleDesc tupleDescriptor = ExecCleanTypeFromTL(workerTargetList, fa    lse);"/>
<node CREATED="1463450219845" ID="ID_442116839" MODIFIED="1463450241559" TEXT="4.4.2 &#x8c03;&#x7528;router executor start:&#xa;RouterExecutorStart(queryDesc, eflags, task);">
<node CREATED="1463478235284" ID="ID_584852450" MODIFIED="1463478292982" TEXT="1.&#x5982;&#x679c;&#x662f;modifyTask, &#x5219;&#x4e0d;&#x5141;&#x8bb8;&#x5728;&#x6267;&#x884c;&#x5206;&#x5e03;&#x5f0f;modify command&#x65f6;&#x6267;&#x884c;&#x4e8b;&#x52a1;&#x548c;triggers:&#xa;if (commandType != CMD_SELECT):&#xa;  PreventTransactionChain(topLevel, &quot;distributed commands&quot;);&#xa;  eflags |= EXEC_FLAG_SKIP_TRIGGERS;"/>
<node CREATED="1463478310730" ID="ID_1164154793" MODIFIED="1463478329620" TEXT="2.&#x4fee;&#x6539;eflags&#x8868;&#x660e;&#x91c7;&#x7528;&#x4e86;router executer:&#xa;eflags |= EXEC_FLAG_CITUS_ROUTER_EXECUTOR;"/>
<node CREATED="1463478330285" ID="ID_83450510" MODIFIED="1463478404841" TEXT="3. build&#x4e00;&#x4e2a;&#x7a7a;&#x7684;&#x6267;&#x884c;&#x5668;&#x72b6;&#x6001;&#x6765;&#x83b7;&#x5f97;&#x6bcf;&#x4e2a;query&#x7684;&#x5185;&#x5b58;&#x4e0a;&#x4e0b;&#x6587;&#xff1a;&#xa;executorState = CreateExecutorState();&#xa;executorState&#x8d4b;&#x503c;"/>
</node>
</node>
<node CREATED="1463450249421" ID="ID_1125037334" MODIFIED="1463625569017" TEXT="4.5 &#x5982;&#x679c;&#x662f;realtime&#x6216;tracker executor:&#xa;&#x6ce8;&#xff1a;&#x8fd9;&#x53ea;&#x53ef;&#x80fd;&#x662f;select&#x8bf7;&#x6c42;&#xff0c;&#xa;&#x56e0;&#x4e3a;update/insert/delete&#x80af;&#x5b9a;&#x8bbe;&#x7f6e;&#x4e3a;&#x4e86;rouer executor.&#xa;(&#x5982;&#x679c;modifytask&#x7684;task&#x4e2a;&#x6570;&#x8d85;&#x8fc7;1&#xff0c;&#x90a3;&#x5728;plan&#x9636;&#x6bb5;&#x5c31;&#x62a5;&#x9519;&#x4e86;&#xff09;">
<node CREATED="1463450284959" ID="ID_648037828" MODIFIED="1463564407614" TEXT="4.5.1 &#x5f97;&#x5230;master plannedStmt&#xff0c;&#x8fd9;&#x662f;&#x5728;&#x6240;&#x6709;work node&#x4e4b;&#x540e;&#x5b8c;&#x6210;&#x540e;&#xff0c;&#xa;&#x5728;master node&#x4e0a;&#x6267;&#x884c;&#x7684;plan:&#xa;PlannedStmt *masterSelectPlan = MasterNodeSelectPlan(multiPlan);&#xa;CreateStmt *masterCreateStmt = MasterNodeCreateStatement(multiPlan)&#xa;List *masterCopyStmtList = MasterNodeCopyStatementList(multiPlan);">
<node CREATED="1463451498741" ID="ID_518177605" MODIFIED="1463451604013" TEXT="MasterNodeSelectPlan&#x5c55;&#x5f00;&#xa;&#x9488;&#x5bf9;&#x5206;&#x5e03;&#x5f0f;plan, &#x5728;plan&#x4e2d;&#x627e;&#x5230;master node&#x8981;&#x6267;&#x884c;&#x7684;query structure,&#xa;&#x5e76;&#x4e14;build&#x5728;master node&#x4e0a;&#x6700;&#x7ec8;&#x6267;&#x884c;&#x7684;select  plan,&#xa;&#x8fd9;&#x4e2a;select&#x662f;&#x5728;&#x6240;&#x6709;worker node&#x4e0a;&#x7684; result file&#x90fd;&#x83b7;&#x5f97;&#x5e76;&#x4e14;merge&#x5230;&#x4e00;&#x4e2a;&#x4e34;&#x65f6;&#x8868;&#x4e4b;&#x540e;&#x624d;&#x6267;&#x884c;&#x7684;&#x3002;">
<node CREATED="1463452495329" ID="ID_8178276" MODIFIED="1463452548850" TEXT="1. &#x5f97;&#x5230;masterQuery(&#x8fd9;&#x662f;&#x5728;multi_physical_planner.c&#x901a;&#x8fc7;&#x6267;&#x884c; &#xa;    BuildJobQuery((MultiNode *) multiTree, masterDependedJobList);&#x5f97;&#x5230;&#x7684;)&#xff1a;&#xa;Query *masterQuery = multiPlan-&gt;masterQuery;&#xa;char *tableName = multiPlan-&gt;masterTableName;"/>
<node CREATED="1463452549397" ID="ID_1669399108" MODIFIED="1463452565251" TEXT="2.  &#x5f97;&#x5230;targetList:&#xa;  Job *workerJob = multiPlan-&gt;workerJob;&#xa;  List *workerTargetList = workerJob-&gt;jobQuery-&gt;targetList;&#xa;  List *masterTargetList = MasterTargetList(workerTargetList);"/>
<node CREATED="1463452565738" ID="ID_459316443" MODIFIED="1463452603306" TEXT="3.  &#x6784;&#x5efa;masterselectplan&#x5e76;&#x8fd4;&#x56de;&#x7ed3;&#x679c;:&#xa;masterSelectPlan = BuildSelectStatement(masterQuery, tableName, masterTargetList);&#xa;return masterSelectPlan;"/>
</node>
<node CREATED="1463539434829" ID="ID_1555059438" MODIFIED="1463564412751" TEXT="MasterNodeCreateStatement&#x5c55;&#x5f00;&#xff1a;&#xa;&#x4e3a;&#x6700;&#x7ec8;&#x7684;&#x7ed3;&#x679c;&#x805a;&#x5408;&#x6784;&#x9020;&#x4e00;&#x4e2a;&#x521b;&#x5efa;&#x4e00;&#x4e2a;&#x4e34;&#x65f6;&#x8868;&#x7684;&#x8bed;&#x53e5;">
<node CREATED="1463541415521" ID="ID_1879118699" MODIFIED="1463541417032" TEXT="1.columnDefinitionList = ColumnDefinitionList(masterColumnNameList, columnTypeList);"/>
<node CREATED="1463541417538" ID="ID_1442223529" MODIFIED="1463541425800" TEXT="2.createStatement = CreateStatement(relation, columnDefinitionList);">
<node CREATED="1463541455806" ID="ID_1949970078" MODIFIED="1463541459447" TEXT="CreateStmt *&#xa;CreateStatement(RangeVar *relation, List *columnDefinitionList)&#xa;{&#xa;  CreateStmt *createStatement = makeNode(CreateStmt);&#xa;  createStatement-&gt;relation = relation;&#xa;  createStatement-&gt;tableElts = columnDefinitionList;&#xa;  createStatement-&gt;inhRelations = NIL;&#xa;  createStatement-&gt;constraints = NIL;&#xa;  createStatement-&gt;options = NIL;&#xa;  createStatement-&gt;oncommit = ONCOMMIT_NOOP;&#xa;  createStatement-&gt;tablespacename = NULL;&#xa;  createStatement-&gt;if_not_exists = false;&#xa;&#xa;  return createStatement;&#xa;}"/>
</node>
</node>
<node CREATED="1463541627500" ID="ID_1834787945" MODIFIED="1463542393930" TEXT="MasterNodeCopyStatementList&#x5c55;&#x5f00;&#xff1a;&#xa;&#x4e3a;&#x6bcf;&#x4e2a;workTask&#x5efa;&#x4e00;&#x4e2a;copystatment, &#xa;&#x7528;&#x4e8e;&#x5c06;&#x6570;&#x636e;&#x62f7;&#x8d1d;&#x5230;master node&#x7684;&#x4e34;&#x65f6;&#x8868;&#x4e2d;&#x3002;">
<node CREATED="1463542396795" ID="ID_841860029" MODIFIED="1463542497703" TEXT="1. foreach(workerTaskCell, workerTaskList){&#xa;1.1 &#x5f97;&#x5230;&#x5f53;&#x524d;task&#x7684;&#x6587;&#x4ef6;&#x8def;&#x5f84;&#xff1a;&#xa;    StringInfo taskFilename = TaskFilename(jobDirectoryName, workerTask-&gt;taskId);&#xa;1.2 &#x4e3a;&#x8be5;task&#x65b0;&#x5efa;&#x4e00;&#x4e2a;copystatment:&#xa;    CopyStmt *copyStatement = makeNode(CopyStmt);&#xa;    copyStatement-&gt;relation = relation;&#xa;    copyStatement-&gt;is_from = true;&#xa;    copyStatement-&gt;filename = taskFilename-&gt;data;&#xa;    &#x653e;&#x5230;copyStatementList &#x4e2d;&#xa;}"/>
<node CREATED="1463542498276" ID="ID_885238742" MODIFIED="1463542505594" TEXT="2. return copyStatementList;"/>
</node>
</node>
<node CREATED="1463450358345" ID="ID_1697134569" MODIFIED="1463450423069" TEXT="4.5.2 &#x5728;master node&#x4e0a;&#x521b;&#x5efa;&#x76ee;&#x5f55;&#x7528;&#x4e8e;&#x4fdd;&#x5b58;task&#x7684;&#x6267;&#x884c;&#x7ed3;&#x679c;&#xff0c;&#xa;&#x5e76;&#x5c06;&#x8be5;&#x76ee;&#x5f55;&#x6ce8;&#x518c;&#x5230;portal delete&#x4e2d;&#xa;jobDirectoryName = JobDirectoryName(workerJob-&gt;jobId);&#xa;CreateDirectory(jobDirectoryName);&#xa;ResourceOwnerEnlargeJobDirectories(CurrentResourceOwner);&#xa;ResourceOwnerRememberJobDirectory(CurrentResourceOwner, workerJob-&gt;jobId);"/>
<node CREATED="1463450427177" ID="ID_1626677547" MODIFIED="1463450458116" TEXT="4.5.3 &#x5982;&#x679c;&#x662f;EXEC_FLAG_EXPLAIN_ONLY&#xff1a;&#xa;&#x5219;&#x5565;&#x4e5f;&#x4e0d;&#x505a;"/>
<node CREATED="1463450459106" ID="ID_1427585505" MODIFIED="1463625789652" TEXT="4.5.4 &#x5982;&#x679c;executorType == MULTI_EXECUTOR_REAL_TIME:&#xa; MultiRealTimeExecute(workerJob);">
<node CREATED="1463553114180" ID="ID_1663741010" MODIFIED="1463554274639" TEXT="1. &#x4e3a;&#x6bcf;&#x4e2a;task &#x521d;&#x59cb;&#x5316;task execution&#x7ed3;&#x6784;&#x4f53;&#xff1a;&#xa;  foreach(taskCell, taskList)&#xa;  {&#xa;    TaskExecution *taskExecution = InitTaskExecution(task, EXEC_TASK_CONNECT_START);&#xa;    &#x628a;&#x5f53;&#x524d;task &#x7684;taskExecution &#x653e;&#x5230;taskExecutionList&#x4e2d;&#xa;  }&#xa;&#x6ce8;: task&#x7684;&#x521d;&#x59cb;&#x72b6;&#x6001;&#x662f;&#xff1a;EXEC_TASK_CONNECT_START"/>
<node CREATED="1463553206649" ID="ID_233706994" MODIFIED="1463553251029" TEXT="2. &#x5faa;&#x73af;&#x6267;&#x884c;&#x76f4;&#x81f3;&#x6240;&#x6709;task&#x5b8c;&#x6210;&#x6216;&#x8005;fail, &#x6216;&#x8005;&#x88ab;cacel&#x6389;&#xff1a;&#xa;while(...){&#xa;}">
<node CREATED="1463553253056" ID="ID_268308257" MODIFIED="1463553345093" TEXT="2.1 &#x5904;&#x7406;&#x6bcf;&#x4e2a;task, &#x4f9d;&#x636e;&#x5f53;&#x524d;task&#x7684;&#x6267;&#x884c;&#x72b6;&#x6001;&#xff0c;&#x5224;&#x65ad;&#x4ed6;&#x4eec;&#x662f;&#x5426;&#x6267;&#x884c;&#x5b8c;&#x6210;&#xff1a;&#xa;forboth(taskCell, taskList, taskExecutionCell, taskExecutionList){&#xa;  &#x5c55;&#x5f00;&#xa;}">
<node CREATED="1463553453436" ID="ID_1473503542" MODIFIED="1463553485538" TEXT="2.1.1 &#x627e;&#x5230;&#x6267;&#x884c;&#x8fd9;&#x4e2a;task&#x7684;work&#x72b6;&#x6001;&#xff1a;&#xa;workerNodeState = LookupWorkerForTask(workerHash, task, taskExecution);"/>
<node CREATED="1463553665126" ID="ID_1639736286" MODIFIED="1463553918307" TEXT="2.1.2&#x5982;&#x679c;&#x5f53;&#x524d;task&#x5df2;&#x7ecf;&#x51c6;&#x5907;&#x597d;&#x6267;&#x884c;(&#x72b6;&#x6001;&#x4e3a;EXEC_TASK_CONNECT_START)&#xff0c;&#xa;&#x4f46;&#x662f;master&#x6216;&#x8005;&#x5bf9;&#x5e94;work&#x8fd8;&#x4e0d;&#x80fd;&#x8fdb;&#x884c;&#x8fde;&#x63a5;&#x65f6;&#xff0c;&#xa;&#x90a3;&#x5148;&#x8df3;&#x8fc7;&#x8fd9;&#x4e2a;task:&#xa;if (TaskExecutionReadyToStart(taskExecution) &amp;&amp;&#xa;        (WorkerConnectionsExhausted(workerNodeState) ||&#xa;         MasterConnectionsExhausted(workerHash)))&#xa;    continue;"/>
<node CREATED="1463553928377" ID="ID_1372904990" MODIFIED="1463553936547" TEXT="2.1.3&#x6267;&#x884c;task :&#xa;connectAction = ManageTaskExecution(task, taskExecution);"/>
<node CREATED="1463553942815" ID="ID_1586112345" MODIFIED="1463553961406" TEXT="2.1.4&#x66f4;&#x65b0;&#x72b6;&#x6001;&#xff0c;&#x5982;work&#x7684;&#x8fde;&#x63a5;&#x6570;&#x76ee;&#xff1a;&#xa;UpdateConnectionCounter(workerNodeState, connectAction);"/>
<node CREATED="1463553978817" ID="ID_1269807431" MODIFIED="1463554002587" TEXT="2.1.5&#x5224;&#x65ad;&#x4efb;&#x52a1;&#x5931;&#x8d25;&#x5426;&#xff0c;&#x5982;&#x679c;&#x5931;&#x8d25;&#x5219;break:&#xa;taskFailed = TaskExecutionFailed(taskExecution);"/>
<node CREATED="1463554031502" ID="ID_673175443" MODIFIED="1463554062673" TEXT="2.1.6&#x5224;&#x65ad;&#x4efb;&#x52a1;&#x6210;&#x529f;&#x5426;&#xff0c;&#x6210;&#x529f;&#x5219;completedTaskCount++:&#xa;taskCompleted = TaskExecutionCompleted(taskExecution);">
<node CREATED="1463554103743" ID="ID_615784692" MODIFIED="1463554134872" TEXT="&#x53ea;&#x8981;taskExecution&#x4e2d;&#x6709;&#x4e00;&#x4e2a;&#x5bf9;&#x5e94;node&#x6267;&#x884c;&#x6210;&#x529f;&#x5c31;&#x53ef;&#x4ee5;&#xff0c;&#xa;task&#x72b6;&#x6001;&#x4e3a;taskStatus == EXEC_TASK_DONE"/>
</node>
</node>
<node CREATED="1463553355713" ID="ID_1060116354" MODIFIED="1463553400169" TEXT="2.2 &#x5982;&#x679c;completedTaskCount == taskcount&#xa;&#x8868;&#x660e;&#x6240;&#x6709;&#x7684;task&#x90fd;&#x6267;&#x884c;&#x5b8c;&#x6210;&#xff0c; &#x9000;&#x51fa;&#x4e0a;&#x5c42;while&#x5faa;&#x73af;"/>
<node CREATED="1463553401139" ID="ID_89861029" MODIFIED="1463553422683" TEXT="2.3 &#x6ca1;&#x6709;&#x6267;&#x884c;&#x5b8c;&#xff0c;&#x5219;sleep&#x51e0;&#x79d2;"/>
</node>
<node CREATED="1463556762542" ID="ID_1378015207" MODIFIED="1463556778821" TEXT="3. &#x770b;&#x662f;&#x5426;&#x6709;&#x8981;cancel&#x6389;&#x7684;&#x4efb;&#x52a1;&#xff1a;&#xa;CancelTaskExecutionIfActive(taskExecution);"/>
<node CREATED="1463556780577" ID="ID_1888224738" MODIFIED="1463556840251" TEXT="4. &#x904d;&#x5386;&#x6bcf;&#x4e2a;task&#xff0c;&#x4e3b;&#x8981;&#x662f;&#x5173;&#x95ed;&#x8fde;&#x63a5;&#x548c;filedesc:&#xa; CleanupTaskExecution(taskExecution);">
<node CREATED="1463556868788" ID="ID_681433200" MODIFIED="1463556891898" TEXT="&#x904d;&#x5386;&#x8fd9;&#x4e2a;taskExecution&#x7684;&#x6bcf;&#x4e2a;node:&#xa;MultiClientDisconnect(connectionId);&#xa;close(fileDescriptor);"/>
</node>
</node>
<node CREATED="1463450477612" ID="ID_691968049" MODIFIED="1463559417271" TEXT="4.5.5  &#x5982;&#x679c;&#x662f;tracker executor&#xa;(executorType == MULTI_EXECUTOR_TASK_TRACKER):&#xa;MultiTaskTrackerExecute(workerJob);"/>
<node CREATED="1463450532329" ID="ID_789211272" MODIFIED="1463450622409" TEXT="4.5.6 &#x521b;&#x5efa;&#x7ed3;&#x679c;&#x8868;&#x5e76;&#x4f7f;&#x5f97;&#x8be5;&#x4e34;&#x65f6;&#x8868;&#x53ef;&#x89c1;&#xff1a;&#xa;ProcessUtility((Node *) masterCreateStmt,&#xa;                    &quot;(temp table creation)&quot;,PROCESS_UTILITY_QUERY,&#xa;                    NULL,None_Receiver,NULL);&#xa;CommandCounterIncrement();"/>
<node CREATED="1463542563175" ID="ID_758800928" MODIFIED="1463557534910" TEXT="4.5.7 &#x62f7;&#x8d1d;&#x7ed3;&#x679c;&#xff1a;CopyQueryResults(masterCopyStmtList);&#xa;&#x5c06;job&#x76ee;&#x5f55;&#x4e0b;&#x7684;&#x6240;&#x6709;&#x6587;&#x4ef6;&#x7684;&#x6570;&#x636e;&#x62f7;&#x8d1d;&#x5230;multiPlan-&gt;masterTableName;">
<node CREATED="1463542598041" ID="ID_828693834" MODIFIED="1463542633165" TEXT="&#x904d;&#x5386;masterCopyStmtList&#x4e2d;&#x7684;&#x6bcf;&#x4e2a;copystatment:&#xa;&#x6267;&#x884c;&#x62f7;&#x8d1d;&#xff1a;&#xa;    ProcessUtility(masterCopyStmt,&#xa;             &quot;(copy job)&quot;,&#xa;             PROCESS_UTILITY_QUERY,&#xa;             NULL,&#xa;             None_Receiver,&#xa;             NULL);"/>
</node>
<node CREATED="1463450643486" ID="ID_1266469964" MODIFIED="1463450685531" TEXT="4.5.7&#xff1a;&#x66f4;&#x65b0;queryDesc&#x7684; snapshot&#x8fd9;&#x6837;&#x5c31;&#x53ef;&#x4ee5;&#x770b;&#x5230;&#x7ed3;&#x679c;&#x8868;&#x4e86;&#xff1a;&#xa;queryDesc-&gt;snapshot-&gt;curcid = GetCurrentCommandId(false);"/>
<node CREATED="1463451269902" ID="ID_1293358630" MODIFIED="1463451306109" TEXT="4.5.8&#x8bbe;&#x7f6e;&#x5728;master&#x7aef;&#x6267;&#x884c;&#x7684;select&#x8bed;&#x53e5;&#x6700;&#x7ec8;&#x7684;&#x8868;&#xff1a;&#xa;masterRangeTableEntry =&#xa;        (RangeTblEntry *) linitial(masterSelectPlan-&gt;rtable);&#xa;masterRangeTableEntry-&gt;relid =&#xa;        RelnameGetRelid(masterRangeTableEntry-&gt;eref-&gt;aliasname);"/>
<node CREATED="1463451321090" ID="ID_1548878730" MODIFIED="1463451352756" TEXT="4.5.9 &#x66ff;&#x6362;queryDesc:&#xa;masterSelectPlan-&gt;queryId = queryDesc-&gt;plannedstmt-&gt;queryId;&#xa;queryDesc-&gt;plannedstmt = masterSelectPlan;&#xa;eflags |= EXEC_FLAG_CITUS_MASTER_SELECT;"/>
</node>
<node CREATED="1463557657343" ID="ID_932890083" MODIFIED="1463557718231" TEXT="4.6&#x5982;&#x679c;&#x8fd9;&#x6b21;&#x6267;&#x884c;&#x4e0d;&#x662f;&#x7531;router executor&#x505a;&#x7684;&#xff0c;&#x90a3;&#x4e48;&#x6267;&#x884c;&#xff1a;&#xa;standard_ExecutorStart(queryDesc, eflags);&#xa;&#x76f8;&#x5f53;&#x4e8e;&#x628a;realtime&#x548c;tracker&#x7684;&#x6267;&#x884c;&#x6700;&#x540e;&#x7684;masterQuery"/>
</node>
<node CREATED="1463478466911" ID="ID_664089241" MODIFIED="1463538958966" TEXT="&#x5206;&#x5e03;&#x5f0f;executor run:&#xa;multi_ExecutorRun">
<node CREATED="1463478484483" ID="ID_481053229" MODIFIED="1463571604103" TEXT="1. &#x5982;&#x679c;&#x662f;router executor(&#x5728;&#x4e00;&#x4e2a;worker&#x4e0a;&#x6267;&#x884c;&#x4e00;&#x4e2a;task):&#xa;&#x5efa;&#x7acb;&#x8fde;&#x63a5;&#x3002;&#x53d1;&#x9001;&#x8bf7;&#x6c42;&#x3002;&#x83b7;&#x5f97;&#x7ed3;&#x679c;&#xa;   RouterExecutorRun(queryDesc, direction, count, task);&#xa;&#x6ce8;&#xff1a;&#x8fd9;&#x4e2a;&#x662f;&#x5728;master node&#x4e0a;&#x6267;&#x884c;&#x7684;&#xff0c;&#xa;&#x76f8;&#x5f53;&#x4e8e;&#x5c06;&#x7ed3;&#x679c;&#x53d1;&#x9001;&#x7ed9;&#x67d0;&#x4e2a;work node&#xff0c;&#xa;&#x5f97;&#x5230;&#x8fd4;&#x56de;&#x7ed3;&#x679c;&#x540e;&#x5b58;&#x50a8;&#x5230;destination&#x4e2d;&#xff0c;&#xa;&#x7528;&#x6237;&#x5c31;&#x53ef;&#x4ee5;&#x770b;&#x5230;&#x8fd9;&#x4e2a;&#x7ed3;&#x679c;&#x4e86;&#x3002;&#xa;&#x6b64;&#x8fc7;&#x7a0b;&#x5e76;&#x6ca1;&#x6709;&#x6d89;&#x53ca;&#x5230;masterQuery.">
<node CREATED="1463478832041" ID="ID_930182885" MODIFIED="1463478856345" TEXT="1.  /* we only support default scan direction and row fetch count */&#xa;  if (!ScanDirectionIsForward(direction))&#xa;  { &#x62a5;&#x9519; }"/>
<node CREATED="1463478869688" ID="ID_207908989" MODIFIED="1463571612668" TEXT="2.&#x5982;&#x679c;&#x662f;modifyTask:&#xa;    int32 affectedRowCount = ExecuteDistributedModify(task);&#xa;    estate-&gt;es_processed = affectedRowCount;&#xa;&#x83b7;&#x5f97;&#x4fee;&#x6539;&#x7684;&#x884c;&#x6570;.&#xa;&#x53ea;&#x8981;&#x6709;&#x4e00;&#x4e2a;taskplacement&#x6267;&#x884c;&#x6210;&#x529f;&#x5c31;&#x6210;&#x529f;">
<node CREATED="1463482847215" ID="ID_516902079" MODIFIED="1463482867761" TEXT="1.&#x5efa;&#x7acb;&#x6216;&#x8005;&#x4ece;cache&#x4e2d;&#x62ff;&#x5230;&#x548c;worker&#x7684;&#x8fde;&#x63a5;&#xff1a;&#xa;connection = GetOrEstablishConnection(nodeName, nodePort);"/>
<node CREATED="1463482874381" ID="ID_1212504275" MODIFIED="1463482888923" TEXT="2. &#x6267;&#x884c;query:&#xa;result = PQexec(connection, task-&gt;queryString);"/>
<node CREATED="1463482903618" ID="ID_753932070" MODIFIED="1463482958164" TEXT="3. &#x83b7;&#x5f97;&#x8fd4;&#x56de;&#x7684;&#x884c;&#x6570;&#xff1a;&#xa;currentAffectedTupleString = PQcmdTuples(result);&#xa;currentAffectedTupleCount = pg_atoi(currentAffectedTupleString, sizeof(int32), 0);&#xa;&#x5982;&#x679c;&#x904d;&#x5386;taskplacement&#x65f6;&#x6709;&#x4e0d;&#x4e00;&#x6837;&#x7684;&#x8fd4;&#x56de;&#x7ed3;&#x679c;&#x5219;&#x62a5;warning."/>
<node CREATED="1463482978320" ID="ID_193749133" MODIFIED="1463482991703" TEXT="4. &#x5982;&#x679c;&#x6240;&#x6709;&#x7684;placement&#x90fd;&#x5931;&#x8d25;&#x4e86;&#xff0c;&#x5219;&#x62a5;&#x9519;"/>
<node CREATED="1463482992697" ID="ID_534694358" MODIFIED="1463483161610" TEXT="5. &#x5bf9;&#x4e8e;&#x6267;&#x884c;&#x51fa;&#x9519;&#x7684;taskplacement, &#x5c06;workernode&#x6807;&#x8bb0;&#x4e3a;inactive:&#xa;&#x5220;&#x9664;pg_dist_shard_placement&#x8868;&#x4e2d;&#x5bf9;&#x4e8e;&#x7684;&#x8bb0;&#x5f55;&#xff1a;&#xa;DeleteShardPlacementRow(failedPlacement-&gt;shardId, failedPlacement-&gt;nodeName,&#xa;                failedPlacement-&gt;nodePort);&#xa;&#x63d2;&#x5165;&#x4e00;&#x6761;&#x65b0;&#x7eaa;&#x5f55;&#x8868;&#x660e;&#x8fd9;&#x4e2a;shardstate&#x662f;inactive &#x7684;&#x3002;&#xa;InsertShardPlacementRow(failedPlacement-&gt;shardId, FILE_INACTIVE, shardLength,&#xa;                failedPlacement-&gt;nodeName, failedPlacement-&gt;nodePort);&#xa;&#x6ce8;&#xff1a;&#x4ee5;&#x4e0a;&#x64cd;&#x4f5c;&#x662f;&#x9488;&#x5bf9;&#x8868;pg_dist_shard_placement&#xa;"/>
</node>
<node CREATED="1463482720599" ID="ID_899605728" MODIFIED="1463483254970" TEXT="3. &#x5982;&#x679c;&#x662f;select:&#xa;ExecuteSingleShardSelect(queryDesc, count, task, estate,&#xa;                 resultTupleDescriptor, destination);&#xa;&#x6ce8;&#xff1a;&#x4f1a;&#x628a;&#x6700;&#x7ec8;&#x7684;&#x7ed3;&#x679c;&#x653e;&#x5230;queryDesc-&gt;dest&#x4e2d;(&#x7c7b;&#x578b;&#xff1a;DestReceiver).">
<node CREATED="1463483441514" ID="ID_1017382354" MODIFIED="1463483629421" TEXT="1. &#x5982;&#x679c;&#x662f;&#x7b2c;&#x4e00;&#x6b21;&#x8c03;&#x7528;&#xff0c;&#x5219;&#x521d;&#x59cb;&#x5316;tuplestore:&#xa;  if (routerState-&gt;tuplestorestate == NULL)&#xa;  {&#xa;    routerState-&gt;tuplestorestate = tuplestore_begin_heap(false, false, work_mem);&#xa;    tupleStore = routerState-&gt;tuplestorestate;&#xa;    resultsOK = ExecuteTaskAndStoreResults(task, tupleDescriptor, tupleStore);&#xa;  }"/>
<node CREATED="1463483638987" ID="ID_1568181816" MODIFIED="1463483640971" TEXT="2.tupleTableSlot = MakeSingleTupleTableSlot(tupleDescriptor);"/>
<node CREATED="1463483643928" ID="ID_462002369" MODIFIED="1463483662488" TEXT="3. &#x542f;&#x52a8;tuple receiver:&#xa;(*destination-&gt;rStartup)(destination, CMD_SELECT, tupleDescriptor);"/>
<node CREATED="1463483699734" ID="ID_1697112127" MODIFIED="1463537997773" TEXT="4. for&#x5faa;&#x73af;&#x5c06;tupleStore&#x4e2d;&#x7684;&#x6bcf;&#x884c;&#x7ed3;&#x679c;&#x5b58;&#x50a8;&#x5230;destination&#x4e2d;&#xff1a;&#xa;//&#x5f97;&#x5230;&#x4e00;&#x4e2a;tuple&#xa;bool nextTuple = tuplestore_gettupleslot(tupleStore, true, false, tupleTableSlot);&#xa;//&#x586b;&#x5145;&#x5230;destination&#x4e2d;&#xff08;&#x5c31;&#x662f;&#x7528;&#x6237;&#x7684;receiver&#x4e2d;&#xff09;&#xa;(*destination-&gt;receiveSlot)(tupleTableSlot, destination);&#xa;//&#x6e05;&#x7a7a;&#x8fd9;&#x4e2a;tupleTableslot&#xff0c;&#x4e3a;&#x4e0b;&#x4e00;&#x884c;&#x505a;&#x51c6;&#x5907;&#xff1a;&#xa;ExecClearTuple(tupleTableSlot);"/>
<node CREATED="1463483740081" ID="ID_422314096" MODIFIED="1463483756576" TEXT="5. &#x662f;&#x5173;&#x95ed; tuple receiver:&#xa; (*destination-&gt;rShutdown)(destination);"/>
<node CREATED="1463483757239" ID="ID_254676794" MODIFIED="1463483773374" TEXT="6. ExecDropSingleTupleTableSlot(tupleTableSlot);"/>
</node>
</node>
<node CREATED="1463478677428" ID="ID_1550285505" MODIFIED="1463478689615" TEXT="2.&#x5426;&#x5219;&#x6267;&#x884c;&#x6807;&#x51c6;&#x7684;&#xff1a;&#xa;standard_ExecutorRun(queryDesc, direction, count);"/>
</node>
<node CREATED="1463538308965" ID="ID_795774053" MODIFIED="1463626750803" TEXT="multi_ExecutorFinish">
<node CREATED="1463538311069" ID="ID_999883636" MODIFIED="1463538332157" TEXT="1.&#x5982;&#x679c;&#x662f;router executer:&#xa;RouterExecutorFinish(queryDesc);"/>
<node CREATED="1463538332551" ID="ID_931113080" MODIFIED="1463538351078" TEXT="2.&#x5426;&#x5219;&#x6267;&#x884c;&#x6807;&#x51c6;&#x7684;:&#xa; standard_ExecutorFinish(queryDesc);"/>
</node>
<node CREATED="1463538394671" ID="ID_808287158" MODIFIED="1463626756337" TEXT="multi_ExecutorEnd">
<node CREATED="1463538396568" ID="ID_1591532059" MODIFIED="1463538412623" TEXT="1.&#x5982;&#x679c;&#x662f;router executer&#xff1a;&#xa;RouterExecutorEnd(queryDesc);"/>
<node CREATED="1463538413235" ID="ID_750061510" MODIFIED="1463538426954" TEXT="2. &#x5426;&#x5219;&#xff1a;&#xa;standard_ExecutorEnd(queryDesc);"/>
<node CREATED="1463538511009" ID="ID_1253963055" MODIFIED="1463538586780" TEXT="3. &#x5982;&#x679c;&#x662f;master select&#x8bf7;&#x6c42;&#xff1a;&#xa;if (eflags &amp; EXEC_FLAG_CITUS_MASTER_SELECT) {&#xa;  &#x6e05;&#x9664;&#x4e34;&#x65f6;&#x8868;&#xff1a;&#xa;  performDeletion(&amp;masterTableObject, DROP_RESTRICT, PERFORM_DELETION_INTERNAL);&#xa;  ...&#xa;}"/>
</node>
</node>
<node CREATED="1463471693340" ID="ID_1453292925" MODIFIED="1463471699622" POSITION="left" TEXT="&#x7ed3;&#x6784;&#x4f53;">
<node CREATED="1463471703695" ID="ID_16639403" MODIFIED="1463562641649" TEXT="physical plan">
<node CREATED="1463471711477" ID="ID_837816380" MODIFIED="1463471717513" TEXT="1. workerJob">
<node CREATED="1463471736870" ID="ID_1375573179" MODIFIED="1463562822144" TEXT="j"/>
<node CREATED="1463471754541" ID="ID_715707020" MODIFIED="1463557839181" TEXT="2. jobQuery&#xa;QUERY&#x7c7b;&#x578b;&#xa;">
<node CREATED="1463472074655" ID="ID_1648092870" MODIFIED="1463472079492" TEXT="1. commandType"/>
<node CREATED="1463472079729" ID="ID_1139417473" MODIFIED="1463472083638" TEXT="2.querySource"/>
<node CREATED="1463472083889" ID="ID_1569743766" MODIFIED="1463562894339" TEXT="3.ultilityStmt"/>
<node CREATED="1463472092051" ID="ID_1645940448" MODIFIED="1463472097594" TEXT="4.resultRelation"/>
<node CREATED="1463472097844" ID="ID_571673208" MODIFIED="1463472105539" TEXT="5.hasAggs"/>
<node CREATED="1463472105764" ID="ID_201546977" MODIFIED="1463472123587" TEXT="6.hasWindowFuncs"/>
<node CREATED="1463472123848" ID="ID_1806282068" MODIFIED="1463472130232" TEXT="7.hasSubLinks"/>
<node CREATED="1463472130453" ID="ID_1229933636" MODIFIED="1463472138981" TEXT="8.hasDistinction"/>
<node CREATED="1463472139163" ID="ID_1379729299" MODIFIED="1463472146972" TEXT="9.hasRecursive"/>
<node CREATED="1463472147191" ID="ID_1052380725" MODIFIED="1463472155741" TEXT="10.hasModifyingCTE"/>
<node CREATED="1463472155941" ID="ID_1323552859" MODIFIED="1463472161100" TEXT="11.hasForUpdate"/>
<node CREATED="1463472161334" ID="ID_1841650077" MODIFIED="1463472168339" TEXT="12.hasRowSecurity"/>
<node CREATED="1463472168707" ID="ID_1580370967" MODIFIED="1463472173709" TEXT="13.cteList"/>
<node CREATED="1463472173924" ID="ID_252765087" MODIFIED="1463472186157" TEXT="14.rtable&#xa;RTE&#x7c7b;&#x578b;">
<node CREATED="1463473717130" ID="ID_579165210" MODIFIED="1463473723252" TEXT="1. alias"/>
<node CREATED="1463473723564" ID="ID_1941127510" MODIFIED="1463473730765" TEXT="2.ered"/>
<node CREATED="1463473731011" ID="ID_399736924" MODIFIED="1463473736844" TEXT="3.rtekind"/>
<node CREATED="1463473737072" ID="ID_52021185" MODIFIED="1463473744324" TEXT="4.functions"/>
<node CREATED="1463473748130" ID="ID_44320237" MODIFIED="1463473755350" TEXT="5.funcordinality"/>
<node CREATED="1463473755573" ID="ID_1282509719" MODIFIED="1463473760150" TEXT="6.lateral"/>
<node CREATED="1463473760375" ID="ID_537628750" MODIFIED="1463473766374" TEXT="7.inh"/>
<node CREATED="1463473766573" ID="ID_1244417370" MODIFIED="1463473773292" TEXT="8.inFromCl"/>
<node CREATED="1463473773853" ID="ID_538662656" MODIFIED="1463473778461" TEXT="9.requirePerms"/>
<node CREATED="1463473778705" ID="ID_1111616919" MODIFIED="1463473785072" TEXT="10.checkAsUser"/>
<node CREATED="1463473785322" ID="ID_173125560" MODIFIED="1463473790453" TEXT="11.selectedCols"/>
<node CREATED="1463473790696" ID="ID_1695280459" MODIFIED="1463473795130" TEXT="12.insertedCols"/>
<node CREATED="1463473795345" ID="ID_1875136041" MODIFIED="1463473801674" TEXT="13.updatedCols"/>
<node CREATED="1463473801894" ID="ID_1628034646" MODIFIED="1463473809903" TEXT="14.securityQuals"/>
</node>
<node CREATED="1463472196917" ID="ID_1692706332" MODIFIED="1463472204448" TEXT="15.jointree"/>
<node CREATED="1463472210490" ID="ID_689286532" MODIFIED="1463472215770" TEXT="16.targetList">
<node CREATED="1463557893452" ID="ID_1084431044" MODIFIED="1463557896950" TEXT="1. expr"/>
<node CREATED="1463557897390" ID="ID_1905373512" MODIFIED="1463557899986" TEXT="2.resno"/>
<node CREATED="1463557900205" ID="ID_888503391" MODIFIED="1463557908561" TEXT="3.ressortgroupred"/>
<node CREATED="1463557908822" ID="ID_480993082" MODIFIED="1463557914845" TEXT="4. resorigtbl"/>
<node CREATED="1463557915052" ID="ID_1190233016" MODIFIED="1463557922726" TEXT="5.resorigcol"/>
<node CREATED="1463557923179" ID="ID_546579919" MODIFIED="1463557929029" TEXT="6.resjunk"/>
</node>
<node CREATED="1463473559877" ID="ID_296167762" MODIFIED="1463473566071" TEXT="17. onConflict"/>
<node CREATED="1463473566462" ID="ID_228208121" MODIFIED="1463473574432" TEXT="18. returningList"/>
<node CREATED="1463473574651" ID="ID_1270008317" MODIFIED="1463473582720" TEXT="19.groupClause"/>
<node CREATED="1463473582952" ID="ID_1920575522" MODIFIED="1463473589330" TEXT="20.groupingSets"/>
<node CREATED="1463473589596" ID="ID_1136472807" MODIFIED="1463473596320" TEXT="21.havingQual"/>
<node CREATED="1463473596567" ID="ID_29601964" MODIFIED="1463473604452" TEXT="22.windowClause"/>
<node CREATED="1463473604683" ID="ID_749925665" MODIFIED="1463473619453" TEXT="23.distinctClause"/>
<node CREATED="1463473619686" ID="ID_784488344" MODIFIED="1463473626220" TEXT="24.sortClause"/>
<node CREATED="1463473626439" ID="ID_356959216" MODIFIED="1463473631923" TEXT="25.limitOffset"/>
<node CREATED="1463473632163" ID="ID_158946605" MODIFIED="1463473637056" TEXT="26.limitCount"/>
<node CREATED="1463473637294" ID="ID_581305696" MODIFIED="1463473647344" TEXT="27.rowMarks"/>
<node CREATED="1463473647604" ID="ID_450287886" MODIFIED="1463473671200" TEXT="28.setOperations"/>
<node CREATED="1463473653806" ID="ID_1962673216" MODIFIED="1463473667061" TEXT="29.constraintDeps"/>
</node>
<node CREATED="1463471778832" ID="ID_1578404304" MODIFIED="1463476557713" TEXT="3. taskList:&#xa;&#x6bcf;&#x4e00;&#x4e2a;task:">
<node CREATED="1463471861083" ID="ID_137660842" MODIFIED="1463471864556" TEXT="1. taskType"/>
<node CREATED="1463471864889" ID="ID_1175650136" MODIFIED="1463471868064" TEXT="2.jobId"/>
<node CREATED="1463471868443" ID="ID_1245868579" MODIFIED="1463471872006" TEXT="3.taskId"/>
<node CREATED="1463471872261" ID="ID_137883557" MODIFIED="1463471878124" TEXT="4.queryString"/>
<node CREATED="1463471878377" ID="ID_154851747" MODIFIED="1463471885606" TEXT="5.anchorShardId"/>
<node CREATED="1463471885852" ID="ID_1236718970" MODIFIED="1463471895034" TEXT="6. taskPlacementList">
<node CREATED="1463472013854" ID="ID_784938269" MODIFIED="1463472019998" TEXT="1. tupleOid"/>
<node CREATED="1463472020607" ID="ID_86027255" MODIFIED="1463472026056" TEXT="2.shardId"/>
<node CREATED="1463472026476" ID="ID_730314579" MODIFIED="1463472031429" TEXT="3. shardLength"/>
<node CREATED="1463472031605" ID="ID_1016159986" MODIFIED="1463472035890" TEXT="4.shardState"/>
<node CREATED="1463472037586" ID="ID_1073723625" MODIFIED="1463472043413" TEXT="5.nodeName"/>
<node CREATED="1463472043657" ID="ID_344416929" MODIFIED="1463472047584" TEXT="6.nodePort"/>
</node>
<node CREATED="1463471895327" ID="ID_660937899" MODIFIED="1463471902753" TEXT="7.dependedTaskList"/>
<node CREATED="1463471902993" ID="ID_1021877483" MODIFIED="1463471908149" TEXT="8.partitionId"/>
<node CREATED="1463471908402" ID="ID_190349466" MODIFIED="1463471916899" TEXT="9.upstreamTaskId"/>
<node CREATED="1463471917132" ID="ID_1367523627" MODIFIED="1463471962614" TEXT="10.shardInterval">
<node CREATED="1463563414444" ID="ID_1574739997" MODIFIED="1463563423584" TEXT="1. relationId"/>
<node CREATED="1463563424382" ID="ID_617348121" MODIFIED="1463563431598" TEXT="2. storageType"/>
<node CREATED="1463563432336" ID="ID_1294114214" MODIFIED="1463563437877" TEXT="3. valueTypeId"/>
<node CREATED="1463563438492" ID="ID_1897845852" MODIFIED="1463563445045" TEXT="4. valueTypeLen"/>
<node CREATED="1463563445730" ID="ID_1644907979" MODIFIED="1463563451217" TEXT="5. valueByVal"/>
<node CREATED="1463563451995" ID="ID_515308976" MODIFIED="1463563460045" TEXT="6. minValueExists"/>
<node CREATED="1463563460587" ID="ID_1333400225" MODIFIED="1463563474526" TEXT="7. maxValueExists"/>
<node CREATED="1463563475115" ID="ID_1665581614" MODIFIED="1463563481518" TEXT="8. minValue"/>
<node CREATED="1463563482652" ID="ID_1667359159" MODIFIED="1463563486604" TEXT="9. maxValue"/>
<node CREATED="1463563489673" ID="ID_318455923" MODIFIED="1463563494787" TEXT="10. shardId"/>
</node>
<node CREATED="1463471962855" ID="ID_324645490" MODIFIED="1463471972843" TEXT="11.assignementConstrained"/>
<node CREATED="1463471973067" ID="ID_1604534071" MODIFIED="1463471980062" TEXT="12. taskExecution">
<node CREATED="1463563257066" ID="ID_945842380" MODIFIED="1463563265929" TEXT="1. jobId"/>
<node CREATED="1463563266873" ID="ID_361903844" MODIFIED="1463563271904" TEXT="2. taskId"/>
<node CREATED="1463563272810" ID="ID_64441711" MODIFIED="1463563292615" TEXT="3. taskStatusArray"/>
<node CREATED="1463563294552" ID="ID_1850804284" MODIFIED="1463563306476" TEXT="4. transmitStatusArray"/>
<node CREATED="1463563307377" ID="ID_157653599" MODIFIED="1463563322709" TEXT="5. connectionIdArray"/>
<node CREATED="1463563323422" ID="ID_1412184650" MODIFIED="1463563332151" TEXT="6. fileDescriptorArray"/>
<node CREATED="1463563332783" ID="ID_598688561" MODIFIED="1463563341888" TEXT="7. connectPollCount"/>
<node CREATED="1463563342514" ID="ID_807342262" MODIFIED="1463563347838" TEXT="8. nodeCount"/>
<node CREATED="1463563348492" ID="ID_1995904291" MODIFIED="1463563354885" TEXT="9. currentNodeIndex"/>
<node CREATED="1463563355610" ID="ID_821497427" MODIFIED="1463563364648" TEXT="10. querySourceNodeIndex"/>
<node CREATED="1463563365101" ID="ID_1528923811" MODIFIED="1463563374128" TEXT="11. dataFetchTaskIndex"/>
<node CREATED="1463563374806" ID="ID_135014903" MODIFIED="1463563380261" TEXT="12. failureCount"/>
</node>
<node CREATED="1463471980318" ID="ID_841401290" MODIFIED="1463471993655" TEXT="13.upsertQuery"/>
</node>
<node CREATED="1463471800448" ID="ID_838402339" MODIFIED="1463471804607" TEXT="4.dependedJobList"/>
<node CREATED="1463471804861" ID="ID_990107943" MODIFIED="1463471815340" TEXT="5. subqueryPushdown"/>
</node>
<node CREATED="1463471718185" ID="ID_188990560" MODIFIED="1463471723552" TEXT="2.masterQuery"/>
<node CREATED="1463471723830" ID="ID_792258627" MODIFIED="1463471736243" TEXT="3. masterTableName"/>
</node>
</node>
</node>
</map>
