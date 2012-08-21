Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ross.burton@intel.com>) id 1T3ryg-0001XA-15
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 19:10:54 +0200
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by mga01.intel.com with ESMTP/TLS/RC4-SHA; 21 Aug 2012 09:17:04 -0700
Received: by wibhr14 with SMTP id hr14so3888974wib.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2012 09:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=o4b9cfE8KJ2XxrbyrRP5agT0edF2RFHEjzGP/nkEJZM=;
	b=P1DG+K+L4NOrEt8bSV70KAmipQDGFnaQch22odnLe1JVu1Ufh5/e+QgsZGUmFnloiy
	w+/xl2I+jHs0c/+bPVKpaV5Q3idhbl4akULeIfPXu+qPWpox6ffGBparwp/njjFQhao/
	pLFuX1LBumA1lSnxJhjvRqafoQxOUzbCj8hH7xNFwkmDFovWV1mJ0+OfmfVOhFsyHWHk
	Uiut+MlHaSqeu/dzsPgIciOV2HpygQ1M0eRSZqwI7bmaVsXlZy1+Qt4JuivYezWk7QmD
	uHk647cf9I2BPgPBJ3rAcmHXGI58Z7T76DXjN5gymgdzMooKdPgX25xaEgwgsJMTuckA
	DrHw==
Received: by 10.180.79.229 with SMTP id m5mr40260541wix.13.1345565823392;
	Tue, 21 Aug 2012 09:17:03 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPS id t8sm34286920wiy.3.2012.08.21.09.17.01
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 21 Aug 2012 09:17:02 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 17:16:25 +0100
Message-Id: <1345565786-23409-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10
X-Gm-Message-State: ALoCoQksth5NtpWeZsh0SaTqBx1nUkaW2ZhaojK0Lm/ZdbiCYsuRFplT2622BHZYOeULEL3k3ugR
Subject: [PATCH 1/2] data-smart: rename the 'content' internal variable to '_content'
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 21 Aug 2012 17:10:54 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/data_smart.py |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 31216e0..dbfcefb 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -280,10 +280,10 @@ class DataSmart(MutableMapping):
                 self._seen_overrides[override].add( var )
 
         # setting var
-        self.dict[var]["content"] = value
+        self.dict[var]["_content"] = value
 
     def getVar(self, var, expand=False, noweakdefault=False):
-        value = self.getVarFlag(var, "content", False, noweakdefault)
+        value = self.getVarFlag(var, "_content", False, noweakdefault)
 
         # Call expand() separately to make use of the expand cache
         if expand and value:
@@ -340,7 +340,7 @@ class DataSmart(MutableMapping):
         if local_var:
             if flag in local_var:
                 value = copy.copy(local_var[flag])
-            elif flag == "content" and "defaultval" in local_var and not noweakdefault:
+            elif flag == "_content" and "defaultval" in local_var and not noweakdefault:
                 value = copy.copy(local_var["defaultval"])
         if expand and value:
             value = self.expand(value, None)
@@ -369,7 +369,7 @@ class DataSmart(MutableMapping):
             self._makeShadowCopy(var)
 
         for i in flags:
-            if i == "content":
+            if i == "_content":
                 continue
             self.dict[var][i] = flags[i]
 
@@ -379,7 +379,7 @@ class DataSmart(MutableMapping):
 
         if local_var:
             for i in local_var:
-                if i == "content":
+                if i == "_content":
                     continue
                 flags[i] = local_var[i]
 
@@ -396,10 +396,10 @@ class DataSmart(MutableMapping):
             content = None
 
             # try to save the content
-            if "content" in self.dict[var]:
-                content  = self.dict[var]["content"]
+            if "_content" in self.dict[var]:
+                content  = self.dict[var]["_content"]
                 self.dict[var]            = {}
-                self.dict[var]["content"] = content
+                self.dict[var]["_content"] = content
             else:
                 del self.dict[var]
 
-- 
1.7.10



