
# This file contains the data used by the three syntax diagram rendering
# programs:
#
#   bubble-generator.tcl
#   bubble-generator-bnf.tcl
#   bubble-generator-bnf.tcl
#

# Graphs:
#
set all_graphs {
  sql-stmt-list {
    toploop {optx sql-stmt} ;
  }
  sql-stmt {
    line
      {opt EXPLAIN {opt QUERY PLAN}}
      {or
         alter-table-stmt
         analyze-stmt
         attach-stmt
         begin-stmt
         commit-stmt
         create-index-stmt
         create-table-stmt
         create-trigger-stmt
         create-view-stmt
         create-virtual-table-stmt
         delete-stmt
         delete-stmt-limited
         detach-stmt
         drop-index-stmt
         drop-table-stmt
         drop-trigger-stmt
         drop-view-stmt
         insert-stmt
         pragma-stmt
         reindex-stmt
         release-stmt
         rollback-stmt
         savepoint-stmt
         select-stmt
         update-stmt
         update-stmt-limited
         vacuum-stmt
      }
  }
  alter-table-stmt {
    stack
       {line ALTER TABLE {optx /database-name .} /table-name}
       {tailbranch
          {line RENAME TO /new-table-name}
          {line ADD {optx COLUMN} column-def}
       }
  }
  analyze-stmt {
     line ANALYZE {or nil /database-name /table-or-index-name
                    {line /database-name . /table-or-index-name}}
  }
  attach-stmt {
     line ATTACH {or DATABASE nil} expr AS /database-name
  }
  begin-stmt {
     line BEGIN {or nil DEFERRED IMMEDIATE EXCLUSIVE}
          {optx TRANSACTION}
  }
  commit-stmt {
     line {or COMMIT END} {optx TRANSACTION}
  }
  rollback-stmt {
     line ROLLBACK {optx TRANSACTION}
        {optx TO {optx SAVEPOINT} /savepoint-name}
  }
  savepoint-stmt {
     line SAVEPOINT /savepoint-name
  }
  release-stmt {
     line RELEASE {optx SAVEPOINT} /savepoint-name
  }
  create-index-stmt {
    stack
       {line CREATE {opt UNIQUE} INDEX {opt IF NOT EXISTS}}
       {line {optx /database-name .} /index-name
             ON /table-name ( {loop indexed-column ,} )}
  }
  indexed-column {
      line /column-name {optx COLLATE /collation-name} {or ASC DESC nil} 
  }
  create-table-stmt {
    stack
       {line CREATE {or {} TEMP TEMPORARY} TABLE {opt IF NOT EXISTS}}
       {line {optx /database-name .} /table-name
          {tailbranch
            {line ( {loop column-def ,} {loop {} {, table-constraint}} )}
            {line AS select-stmt}
          }
       }
  }
  column-def {
    line /column-name {or type-name nil} {loop nil {nil column-constraint nil}}
  }
  type-name {
     line {loop /name {}} {or {}
        {line ( signed-number )}
        {line ( signed-number , signed-number )}
     }
  }
  column-constraint {
    stack
      {optx CONSTRAINT /name}
      {or
         {line PRIMARY KEY {or nil ASC DESC} 
               conflict-clause {opt AUTOINCREMENT}
         }
         {line NOT NULL conflict-clause}
         {line UNIQUE conflict-clause}
         {line CHECK ( expr )}
         {line DEFAULT 
            {or
                signed-number
                literal-value
                {line ( expr )}
            }
         }
         {line COLLATE /collation-name}
         {line foreign-key-clause}
      }
  }
  signed-number {
     line {or nil + -} /numeric-literal
  }
  table-constraint {
     stack
       {optx CONSTRAINT /name}
       {or
          {line {or {line PRIMARY KEY} UNIQUE}
                ( {loop indexed-column ,} ) conflict-clause}
          {line CHECK ( expr )}
          {line FOREIGN KEY ( {loop /column-name ,} ) foreign-key-clause }
       }
  }
  foreign-key-clause {
      stack 
        {line REFERENCES /foreign-table {optx ( {loop /column-name ,} )}}
        {optx 
          {loop
             {or 
                {line ON {or DELETE UPDATE}
                         {or {line SET NULL} {line SET DEFAULT}
                             CASCADE RESTRICT {line NO ACTION}
                         }
                }
                {line MATCH /name}
             }
             {}
          }
        }
        {optx
          {line {optx NOT} DEFERRABLE 
             {or 
                {line INITIALLY DEFERRED}
                {line INITIALLY IMMEDIATE}
                {}
             }
          }
          nil
        }
  }
  conflict-clause {
    opt {line ON CONFLICT {or ROLLBACK ABORT FAIL IGNORE REPLACE}}
  }
  create-trigger-stmt {
    stack
       {line CREATE {or {} TEMP TEMPORARY} TRIGGER {opt IF NOT EXISTS}}
       {line {optx /database-name .} /trigger-name
             {or BEFORE AFTER {line INSTEAD OF} nil}
       }
       {line
             {or DELETE INSERT 
                 {line UPDATE {opt OF {loop /column-name ,} }}
             }
             ON /table-name
       }
       {line {optx FOR EACH ROW}
             {optx WHEN expr}
       }
       {line BEGIN
             {loop 
                {line {or update-stmt insert-stmt delete-stmt select-stmt} ;} 
                nil
             }
             END
       }
  }
  create-view-stmt {
    stack
       {line CREATE {or {} TEMP TEMPORARY} VIEW {opt IF NOT EXISTS}}
       {line {optx /database-name .} /view-name AS select-stmt}
  }
  create-virtual-table-stmt {
    stack
       {line CREATE VIRTUAL TABLE {optx /database-name .} /table-name}
       {line USING /module-name {optx ( {loop /module-argument ,} )}}
  }
  delete-stmt {
    line DELETE FROM qualified-table-name {optx WHERE expr}
  }
  delete-stmt-limited {
    stack
        {line DELETE FROM qualified-table-name {optx WHERE expr}}
        {optx
            {stack
              {optx ORDER BY {loop ordering-term ,}}
              {line LIMIT /expr {optx {or OFFSET ,} /expr}}
            }
        }
  }
  detach-stmt {
    line DETACH {optx DATABASE} /database-name
  }
  drop-index-stmt {
    line DROP INDEX {optx IF EXISTS} {optx /database-name .} /index-name
  }
  drop-table-stmt {
    line DROP TABLE {optx IF EXISTS} {optx /database-name .} /table-name
  }
  drop-trigger-stmt {
    line DROP TRIGGER {optx IF EXISTS} {optx /database-name .} /trigger-name
  }
  drop-view-stmt {
    line DROP VIEW {optx IF EXISTS} {optx /database-name .} /view-name
  }
  expr {
    or
     {line literal-value}
     {line bind-parameter}
     {line {optx {optx /database-name .} /table-name .} /column-name}
     {line /unary-operator expr}
     {line expr /binary-operator expr}
     {line /function-name ( {or {line {optx DISTINCT} {toploop expr ,}} {} *} )}
     {line ( expr )}
     {line CAST ( expr AS type-name )}
     {line expr COLLATE /collation-name}
     {line expr {optx NOT} {or LIKE GLOB REGEXP MATCH} expr
           {optx ESCAPE expr}}
     {line expr {or ISNULL NOTNULL {line NOT NULL}}}
     {line expr IS {optx NOT} expr}
     {line expr {optx NOT} BETWEEN expr AND expr}
     {line expr {optx NOT} IN 
            {or
               {line ( {or {} select-stmt {loop expr ,}} )}
               {line {optx /database-name .} /table-name}
            }
     }
     {line {optx {optx NOT} EXISTS} ( select-stmt )}
     {line CASE {optx expr} {loop {line WHEN expr THEN expr} {}}
           {optx ELSE expr} END}
     {line raise-function}
  }
  raise-function {
     line RAISE ( 
           {or IGNORE
               {line {or ROLLBACK ABORT FAIL} , /error-message }
           } )
  }
  literal-value {
    or
     {line /numeric-literal}
     {line /string-literal}
     {line /blob-literal}
     {line NULL}
     {line CURRENT_TIME}
     {line CURRENT_DATE}
     {line CURRENT_TIMESTAMP}
  }
  numeric-literal {
    line {or
            {line {loop /digit nil} {opt /decimal-point {loop nil /digit}}}
            {line /decimal-point {loop /digit nil}}
         }
         {opt E {or nil + -} {loop /digit nil}}
  }
  insert-stmt {
    stack
       {line
          {or 
              {line INSERT {opt OR {or ROLLBACK ABORT REPLACE FAIL IGNORE}}}
              REPLACE
          }
          INTO {optx /database-name .} /table-name
       }
       {tailbranch
          {line 
                {optx ( {loop /column-name ,} )}
                {tailbranch
                    {line VALUES ( {loop expr ,} )}
                    select-stmt
                }
          }
          {line DEFAULT VALUES}
       }
  }
  pragma-stmt {
     line PRAGMA {optx /database-name .} /pragma-name
          {or
              nil
              {line = pragma-value}
              {line ( pragma-value )}
          }
  }
  pragma-value {
     or
        signed-number
        /name
        /string-literal
  }
  reindex-stmt {
     line REINDEX
          {tailbranch nil
             /collation-name
             {line {optx /database-name .}
                 {tailbranch /table-name /index-name}
             }
          }
  }
  select-stmt {
    stack
       {loop {line select-core nil} {nil compound-operator nil}}
       {optx ORDER BY {loop ordering-term ,}}
       {optx LIMIT /expr {optx {or OFFSET ,} /expr}}
  }
  select-core {
     stack
       {line SELECT {or nil DISTINCT ALL} {loop result-column ,}}
       {optx FROM join-source}
       {optx WHERE expr}
       {optx GROUP BY {loop ordering-term ,} {optx HAVING expr}}
        
  }
  result-column {
     or
        *
        {line /table-name . *}
        {line expr {optx {optx AS} /column-alias}}
  }
  join-source {
     line
        single-source
        {opt {loop {line nil join-op single-source join-constraint nil} {}}}
  }
  single-source {
     or
       {line
          {optx /database-name .} /table-name
          {optx {optx AS} /table-alias}
          {or nil {line INDEXED BY /index-name} {line NOT INDEXED}}
       }
       {line
          ( select-stmt ) {optx {optx AS} /table-alias}
       }
       {line ( join-source )}
  }
  join-op {
     or
        {line ,}
        {line
            {opt NATURAL}
            {or  nil {line LEFT {or OUTER nil}} INNER CROSS}
            JOIN
        }
  }
  join-constraint {
     or
        {line ON expr}
        {line USING ( {loop /column-name ,} )}
        nil
  }
  ordering-term {
      line expr {opt COLLATE /collation-name} {or nil ASC DESC} 
  }
  compound-operator {
     or {line UNION {optx ALL}} INTERSECT EXCEPT
  }
  update-stmt {
     stack
        {line UPDATE {opt OR {or ROLLBACK ABORT REPLACE FAIL IGNORE}}
              qualified-table-name}
        {line SET {loop {line /column-name = expr} ,} {optx WHERE expr}}
  }
  update-stmt-limited {
     stack
        {line UPDATE {opt OR {or ROLLBACK ABORT REPLACE FAIL IGNORE}}
              qualified-table-name}
        {line SET {loop {line /column-name = expr} ,} {optx WHERE expr}}
        {optx
            {stack
              {optx ORDER BY {loop ordering-term ,}}
              {line LIMIT /expr {optx {or OFFSET ,} /expr}}
            }
        }
  }
  qualified-table-name {
     line {optx /database-name .} /table-name
          {or nil {line INDEXED BY /index-name} {line NOT INDEXED}}
  }
  vacuum-stmt {
      line VACUUM
  }
  comment-syntax {
    or
      {line -- {loop nil /anything-except-newline} 
           {or /newline /end-of-input}}
      {line /* {loop nil /anything-except-*/}
           {or */ /end-of-input}}
  }
}
