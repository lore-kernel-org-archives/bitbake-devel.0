Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail.openembedded.org (Postfix) with ESMTP id 32E947C07F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Jan 2019 16:12:56 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id y185so7727313wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Jan 2019 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WKylNIEhsg3lD/rEmOpWxiayucBU4//e14Yi/7DLTc8=;
	b=Jdih9gh8nWJ8wWG6s8FumZhUOAviLnOUwTn8XpDkMcCPQfW6tjbLnHsKk3OqR0gxze
	/8+/LAks+wdW9hMxbUpxiIZMPr5cbyBQAz9xJwccpr14R8u4i4rZDrPCsOWW1bCHqmLJ
	W1KTx8Mytie3X4yu8d9Dmx9fUZ3dStbAY1hnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WKylNIEhsg3lD/rEmOpWxiayucBU4//e14Yi/7DLTc8=;
	b=U740YeWukVPrrcZjJngBGYkUSZw7zfqyTN7KYJlhkxm3BacSa6otsVdKkbKAYIFqqv
	MZNZv0O2XjFuEvT1HnOhY2KDlJWV/iEtOFOHK78pZ2IgGKI9drWzi48UZ88wlliupU8g
	8O8w3F8VY2shPpgwOCQY48I+7yLVY/ikiEvoibeKIQdYukjrH10OiMAIGI7QjrLhpno9
	eKxpu8Ch4YweAcPk+ykq6UtZpx8cqLo/dNXxvS6tqEiY3brxk0gj+VaHYu5pIxgTPNQo
	4YEB2FB8ptLESmKv8wIZBTPNcIZa9VdRmtYeHjlzB15GDEdSfqUUeVGuLpQopKDNHl0E
	60zw==
X-Gm-Message-State: AJcUukdkDymUtghCjIbCyY5MsVb2glIRVe5zrRrkWFRbStVJqXEsCjqi
	D2bpk/DbJ8g7ONIbbaFL6w2UgzutAvA=
X-Google-Smtp-Source: ALg8bN79HedAAyMCPEExLGqsdKKx5YouMWi3p1VXSjoE55W+yVDbgQBDQPb4JLaN1afwcU1MH3PV8g==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr12040301wmk.37.1547482376074; 
	Mon, 14 Jan 2019 08:12:56 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	200sm31159895wmw.31.2019.01.14.08.12.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 14 Jan 2019 08:12:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Jan 2019 16:12:54 +0000
Message-Id: <20190114161254.8241-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: Fix Deprecated warnings from regexs
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
X-List-Received-Date: Mon, 14 Jan 2019 16:12:56 -0000
Content-Transfer-Encoding: 8bit

Fix handling of escape characters in regexs and hence fix python
Deprecation warnings which will be problematic in python 3.8.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py               |  4 ++--
 lib/bb/fetch2/wget.py              | 24 ++++++++++++------------
 lib/bb/monitordisk.py              | 12 ++++++------
 lib/bb/parse/parse_py/BBHandler.py | 18 +++++++++---------
 lib/bb/providers.py                |  4 ++--
 lib/bb/siggen.py                   |  2 +-
 lib/bs4/dammit.py                  | 12 ++++++------
 lib/bs4/element.py                 |  8 ++++----
 8 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 59a2ee8f80..c3c089233b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -615,7 +615,7 @@ class Git(FetchMethod):
         """
         pupver = ('', '')
 
-        tagregex = re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or "(?P<pver>([0-9][\.|_]?)+)")
+        tagregex = re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or r"(?P<pver>([0-9][\.|_]?)+)")
         try:
             output = self._lsremote(ud, d, "refs/tags/*")
         except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess) as e:
@@ -630,7 +630,7 @@ class Git(FetchMethod):
 
             tag_head = line.split("/")[-1]
             # Ignore non-released branches
-            m = re.search("(alpha|beta|rc|final)+", tag_head)
+            m = re.search(r"(alpha|beta|rc|final)+", tag_head)
             if m:
                 continue
 
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 1237e56098..e2037511da 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -481,7 +481,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile("(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])+(\d+))")
+        dirver_regex = re.compile(r"(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])+(\d+))")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group('ver')
@@ -541,26 +541,26 @@ class Wget(FetchMethod):
                 gst-fluendo-mp3
         """
         # match most patterns which uses "-" as separator to version digits
-        pn_prefix1 = "[a-zA-Z][a-zA-Z0-9]*([-_][a-zA-Z]\w+)*\+?[-_]"
+        pn_prefix1 = r"[a-zA-Z][a-zA-Z0-9]*([-_][a-zA-Z]\w+)*\+?[-_]"
         # a loose pattern such as for unzip552.tar.gz
-        pn_prefix2 = "[a-zA-Z]+"
+        pn_prefix2 = r"[a-zA-Z]+"
         # a loose pattern such as for 80325-quicky-0.4.tar.gz
-        pn_prefix3 = "[0-9]+[-]?[a-zA-Z]+"
+        pn_prefix3 = r"[0-9]+[-]?[a-zA-Z]+"
         # Save the Package Name (pn) Regex for use later
-        pn_regex = "(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
+        pn_regex = r"(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
 
         # match version
-        pver_regex = "(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
+        pver_regex = r"(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
 
         # match arch
         parch_regex = "-source|_all_"
 
         # src.rpm extension was added only for rpm package. Can be removed if the rpm
         # packaged will always be considered as having to be manually upgraded
-        psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
+        psuffix_regex = r"(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
-        package_regex_comp = re.compile("(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
+        package_regex_comp = re.compile(r"(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
                                                     % (pn_regex, pver_regex, parch_regex, psuffix_regex))
         self.suffix_regex_comp = re.compile(psuffix_regex)
 
@@ -572,7 +572,7 @@ class Wget(FetchMethod):
             version = self._parse_path(package_regex_comp, package)
             if version:
                 package_custom_regex_comp = re.compile(
-                    "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s)" %
+                    r"(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s)" %
                     (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
             else:
                 package_custom_regex_comp = None
@@ -589,7 +589,7 @@ class Wget(FetchMethod):
         current_version = ['', d.getVar('PV'), '']
 
         """possible to have no version in pkg name, such as spectrum-fw"""
-        if not re.search("\d+", package):
+        if not re.search(r"\d+", package):
             current_version[1] = re.sub('_', '.', current_version[1])
             current_version[1] = re.sub('-', '.', current_version[1])
             return (current_version[1], '')
@@ -607,13 +607,13 @@ class Wget(FetchMethod):
 
             # search for version matches on folders inside the path, like:
             # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
-            dirver_regex = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
+            dirver_regex = re.compile(r"(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
             m = dirver_regex.search(path)
             if m:
                 pn = d.getVar('PN')
                 dirver = m.group('dirver')
 
-                dirver_pn_regex = re.compile("%s\d?" % (re.escape(pn)))
+                dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
                         package, package_regex, current_version, ud, d), '')
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 833cd3d344..2ad1e61562 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -28,16 +28,16 @@ def convertGMK(unit):
 
     """ Convert the space unit G, M, K, the unit is case-insensitive """
 
-    unitG = re.match('([1-9][0-9]*)[gG]\s?$', unit)
+    unitG = re.match(r'([1-9][0-9]*)[gG]\s?$', unit)
     if unitG:
         return int(unitG.group(1)) * (1024 ** 3)
-    unitM = re.match('([1-9][0-9]*)[mM]\s?$', unit)
+    unitM = re.match(r'([1-9][0-9]*)[mM]\s?$', unit)
     if unitM:
         return int(unitM.group(1)) * (1024 ** 2)
-    unitK = re.match('([1-9][0-9]*)[kK]\s?$', unit)
+    unitK = re.match(r'([1-9][0-9]*)[kK]\s?$', unit)
     if unitK:
         return int(unitK.group(1)) * 1024
-    unitN = re.match('([1-9][0-9]*)\s?$', unit)
+    unitN = re.match(r'([1-9][0-9]*)\s?$', unit)
     if unitN:
         return int(unitN.group(1))
     else:
@@ -83,7 +83,7 @@ def getDiskData(BBDirs, configuration):
     for pathSpaceInode in BBDirs.split():
         # The input format is: "dir,space,inode", dir is a must, space
         # and inode are optional
-        pathSpaceInodeRe = re.match('([^,]*),([^,]*),([^,]*),?(.*)', pathSpaceInode)
+        pathSpaceInodeRe = re.match(r'([^,]*),([^,]*),([^,]*),?(.*)', pathSpaceInode)
         if not pathSpaceInodeRe:
             printErr("Invalid value in BB_DISKMON_DIRS: %s" % pathSpaceInode)
             return None
@@ -147,7 +147,7 @@ def getInterval(configuration):
     else:
         # The disk space or inode interval is optional, but it should
         # have a correct value once it is specified
-        intervalRe = re.match('([^,]*),?\s*(.*)', interval)
+        intervalRe = re.match(r'([^,]*),?\s*(.*)', interval)
         if intervalRe:
             intervalSpace = intervalRe.group(1)
             if intervalSpace:
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index f3bf4aa529..9dba5f2334 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -38,15 +38,15 @@ from .ConfHandler import include, init
 # For compatibility
 bb.deprecate_import(__name__, "bb.parse", ["vars_from_file"])
 
-__func_start_regexp__    = re.compile( r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(?P<func>[\w\.\-\+\{\}\$]+)?\s*\(\s*\)\s*{$" )
-__inherit_regexp__       = re.compile( r"inherit\s+(.+)" )
-__export_func_regexp__   = re.compile( r"EXPORT_FUNCTIONS\s+(.+)" )
-__addtask_regexp__       = re.compile("addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
-__deltask_regexp__       = re.compile("deltask\s+(?P<func>\w+)")
-__addhandler_regexp__    = re.compile( r"addhandler\s+(.+)" )
-__def_regexp__           = re.compile( r"def\s+(\w+).*:" )
-__python_func_regexp__   = re.compile( r"(\s+.*)|(^$)|(^#)" )
-__python_tab_regexp__    = re.compile(" *\t")
+__func_start_regexp__    = re.compile(r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(?P<func>[\w\.\-\+\{\}\$]+)?\s*\(\s*\)\s*{$" )
+__inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
+__export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
+__addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
+__deltask_regexp__       = re.compile(r"deltask\s+(?P<func>\w+)")
+__addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
+__def_regexp__           = re.compile(r"def\s+(\w+).*:" )
+__python_func_regexp__   = re.compile(r"(\s+.*)|(^$)|(^#)" )
+__python_tab_regexp__    = re.compile(r" *\t")
 
 __infunc__ = []
 __inpython__ = False
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index c2aa98c065..f496d84d12 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -129,7 +129,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
         preferred_v = cfgData.getVar("PREFERRED_VERSION")
 
     if preferred_v:
-        m = re.match('(\d+:)*(.*)(_.*)*', preferred_v)
+        m = re.match(r'(\d+:)*(.*)(_.*)*', preferred_v)
         if m:
             if m.group(1):
                 preferred_e = m.group(1)[:-1]
@@ -384,7 +384,7 @@ def getRuntimeProviders(dataCache, rdepend):
 
     # Only search dynamic packages if we can't find anything in other variables
     for pattern in dataCache.packages_dynamic:
-        pattern = pattern.replace('+', "\+")
+        pattern = pattern.replace(r'+', r"\+")
         if pattern in regexp_cache:
             regexp = regexp_cache[pattern]
         else:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 66aea79355..03aa08bb94 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -90,7 +90,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
-        self.pkgnameextract = re.compile("(?P<fn>.*)\..*")
+        self.pkgnameextract = re.compile(r"(?P<fn>.*)\..*")
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
diff --git a/lib/bs4/dammit.py b/lib/bs4/dammit.py
index 68d419feb5..805aa908a5 100644
--- a/lib/bs4/dammit.py
+++ b/lib/bs4/dammit.py
@@ -45,9 +45,9 @@ except ImportError:
     pass
 
 xml_encoding_re = re.compile(
-    '^<\?.*encoding=[\'"](.*?)[\'"].*\?>'.encode(), re.I)
+    r'^<\?.*encoding=[\'"](.*?)[\'"].*\?>'.encode(), re.I)
 html_meta_re = re.compile(
-    '<\s*meta[^>]+charset\s*=\s*["\']?([^>]*?)[ /;\'">]'.encode(), re.I)
+    r'<\s*meta[^>]+charset\s*=\s*["\']?([^>]*?)[ /;\'">]'.encode(), re.I)
 
 class EntitySubstitution(object):
 
@@ -80,11 +80,11 @@ class EntitySubstitution(object):
         ">": "gt",
         }
 
-    BARE_AMPERSAND_OR_BRACKET = re.compile("([<>]|"
-                                           "&(?!#\d+;|#x[0-9a-fA-F]+;|\w+;)"
-                                           ")")
+    BARE_AMPERSAND_OR_BRACKET = re.compile(r"([<>]|"
+                                           r"&(?!#\d+;|#x[0-9a-fA-F]+;|\w+;)"
+                                           r")")
 
-    AMPERSAND_OR_BRACKET = re.compile("([<>&])")
+    AMPERSAND_OR_BRACKET = re.compile(r"([<>&])")
 
     @classmethod
     def _substitute_html_entity(cls, matchobj):
diff --git a/lib/bs4/element.py b/lib/bs4/element.py
index 0c30759ffc..3775a60458 100644
--- a/lib/bs4/element.py
+++ b/lib/bs4/element.py
@@ -10,7 +10,7 @@ from bs4.dammit import EntitySubstitution
 DEFAULT_OUTPUT_ENCODING = "utf-8"
 PY3K = (sys.version_info[0] > 2)
 
-whitespace_re = re.compile("\s+")
+whitespace_re = re.compile(r"\s+")
 
 def _alias(attr):
     """Alias one attribute name to another for backward compatibility"""
@@ -67,7 +67,7 @@ class ContentMetaAttributeValue(AttributeValueWithCharsetSubstitution):
     The value of the 'content' attribute will be one of these objects.
     """
 
-    CHARSET_RE = re.compile("((^|;)\s*charset=)([^;]*)", re.M)
+    CHARSET_RE = re.compile(r"((^|;)\s*charset=)([^;]*)", re.M)
 
     def __new__(cls, original_value):
         match = cls.CHARSET_RE.search(original_value)
@@ -580,7 +580,7 @@ class PageElement(object):
 
     # Methods for supporting CSS selectors.
 
-    tag_name_re = re.compile('^[a-zA-Z0-9][-.a-zA-Z0-9:_]*$')
+    tag_name_re = re.compile(r'^[a-zA-Z0-9][-.a-zA-Z0-9:_]*$')
 
     # /^([a-zA-Z0-9][-.a-zA-Z0-9:_]*)\[(\w+)([=~\|\^\$\*]?)=?"?([^\]"]*)"?\]$/
     #   \---------------------------/  \---/\-------------/    \-------/
@@ -1364,7 +1364,7 @@ class Tag(PageElement):
                 if tag_name == '':
                     raise ValueError(
                         "A pseudo-class must be prefixed with a tag name.")
-                pseudo_attributes = re.match('([a-zA-Z\d-]+)\(([a-zA-Z\d]+)\)', pseudo)
+                pseudo_attributes = re.match(r'([a-zA-Z\d-]+)\(([a-zA-Z\d]+)\)', pseudo)
                 found = []
                 if pseudo_attributes is None:
                     pseudo_type = pseudo
-- 
2.19.1


