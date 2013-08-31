Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 24D216BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 22:42:27 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMt9NJ008547 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:55:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Dob2TAcay9E8 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:55:09 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMt3ip008544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:55:05 +0100
Message-ID: <1377988933.1059.131.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 31 Aug 2013 23:42:13 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] serv/db: Don't use BEGIN/COMMIT
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 31 Aug 2013 22:42:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Since we don't support using multiple servers on the same database file,
don't use the BEGIN/COMMIT syntax and allow writes to the database
to work ~100 times faster with no transaction locking.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index b7190ba..dad445b 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -52,11 +52,9 @@ class PRTable(object):
         else:
             #no value found, try to insert
             try:
-                self._execute("BEGIN")
-                self._execute("INSERT OR ROLLBACK INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
+                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
                            % (self.table,self.table),
                            (version,pkgarch, checksum,version, pkgarch))
-                self.conn.commit()
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
@@ -80,11 +78,9 @@ class PRTable(object):
         else:
             #no value found, try to insert
             try:
-                self._execute("BEGIN")
                 self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
                                % (self.table,self.table),
                                (version, pkgarch, checksum, version, pkgarch))
-                self.conn.commit()
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
                 self.conn.rollback()
@@ -113,10 +109,8 @@ class PRTable(object):
         else:
             #no value found, try to insert
             try:
-                self._execute("BEGIN")
-                self._execute("INSERT OR ROLLBACK INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
                            (version, pkgarch, checksum, value))
-                self.conn.commit()
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
@@ -130,18 +124,14 @@ class PRTable(object):
     def _importNohist(self, version, pkgarch, checksum, value):
         try:
             #try to insert
-            self._execute("BEGIN")
-            self._execute("INSERT OR ROLLBACK INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
                            (version, pkgarch, checksum,value))
-            self.conn.commit()
         except sqlite3.IntegrityError as exc:
             #already have the record, try to update
             try:
-                self._execute("BEGIN")
                 self._execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"  
                               % (self.table),
                                (value,version,pkgarch,checksum,value))
-                self.conn.commit()
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 



