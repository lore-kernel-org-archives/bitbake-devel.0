Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail.openembedded.org (Postfix) with ESMTP id E43316021B
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Mar 2020 20:02:32 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id f3so1125181ioc.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Mar 2020 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/aMzZhtx1YlYYUVfixnLkvI7PakVrIglfWAyu7BmrZY=;
	b=qdp5kAzMrcoR0w8curIyYiEnWMOmjPulth+Oh9rokjDfN7BLaNpnPa07GboH3niqZI
	WclsqxSh/a3uMQ9Wvf90uAEWkhYipJfdk4+Md0SRRe0u8PApeeqQxux2futJnM/ZyEhS
	U5cLlIZ5tv1Fen3ZhvogLucEhXgDssf/GM1lyANAExZ+OSzlLdHzfkx31AHeOeJdCD7y
	B3qfGp4f9smQCRt+pzdrWtpOD7QT7ikTYKpSem5XQquLuxZQbF0aygXN3XoeaXgIg5UO
	luMADCQgKnHmYPdNmGkUGLeFVRx6Tld07Dbq+V9Jzhex4owtAucckLGxn7l6hTCOwMp1
	35ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/aMzZhtx1YlYYUVfixnLkvI7PakVrIglfWAyu7BmrZY=;
	b=g4J8e0+lwW+fSzSEMoh9Lc3ec1DxfACKakThgYy8AOnp5CwmohpOQDHLv6DkcIKCUR
	KLYd2jgVuZo2U2osaVMsl8Zw/W8a3gZYbohEyPCthcop+sus+0lBJJpaFTUOpTFcFQnR
	blXlYdEsZbq47enTusLlGdPCKO4iiYMr3HkBFVxM4cV0+7/TL5iMsCGVrh1RRblDBZAL
	EbwXPMkB46CLkygD6BVlCKhaW3XYCuJEAvcPw1WnLqubK9Ggnik0J7JOuPoYYmXpLwfk
	ch09jqiQTtIM+UwLBM1xMjIos4ZGnyGiWpO5odL28TlNKK+fbownoTrOmArJpJcXglND
	tlzw==
X-Gm-Message-State: ANhLgQ3dVLKeYFosmFLYl4o8hznWXF8bUKq+FTb/vzYgyzECTVRTAq9e
	80EoC4Vli/0/wjJ4wbL9LKyUvGfuuHQ=
X-Google-Smtp-Source: ADFU+vvHEjft3AFB+kzXq7YuLcwKoJy9yxzgt5g15L0eozi4sMh5kCL2WbF/TKsHJkekCzBoBjkMiA==
X-Received: by 2002:a05:6638:a9b:: with SMTP id
	27mr4292134jas.70.1583352153607; 
	Wed, 04 Mar 2020 12:02:33 -0800 (PST)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j4sm7310626ilf.21.2020.03.04.12.02.32
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Mar 2020 12:02:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Mar 2020 14:02:26 -0600
Message-Id: <20200304200226.23771-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304200226.23771-1-JPEWhacker@gmail.com>
References: <20200304200226.23771-1-JPEWhacker@gmail.com>
Subject: [PATCH 4/4] bitbake: bblayers: query: Add multiconfig option
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
X-List-Received-Date: Wed, 04 Mar 2020 20:02:34 -0000

Adds an option to the show-recipes subcommand that allows the user to
specify which multiconfig should be shown.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bblayers/query.py | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index 7db49c8e2a..e2cc310532 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -46,7 +46,7 @@ layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
 """
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None, args.mc)
 
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
@@ -112,9 +112,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
             title = 'Matching recipes:'
         else:
             title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, args.bare, inheritlist)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, args.bare, inheritlist, args.mc)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, bare, inherits):
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, bare, inherits, mc):
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
@@ -123,14 +123,18 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     logger.error('No class named %s found in BBPATH', classfile)
                     sys.exit(1)
 
-        pkg_pn = self.tinfoil.cooker.recipecaches[''].pkg_pn
-        (latest_versions, preferred_versions) = self.tinfoil.find_providers()
-        allproviders = self.tinfoil.get_all_providers()
+        pkg_pn = self.tinfoil.cooker.recipecaches[mc].pkg_pn
+        (latest_versions, preferred_versions) = self.tinfoil.find_providers(mc)
+        allproviders = self.tinfoil.get_all_providers(mc)
 
         # Ensure we list skipped recipes
         # We are largely guessing about PN, PV and the preferred version here,
         # but we have no choice since skipped recipes are not fully parsed
         skiplist = list(self.tinfoil.cooker.skiplist.keys())
+        mcspec = 'mc:%s:' % mc
+        if mc:
+            skiplist = [s[len(mcspec):] for s in skiplist if s.startswith(mcspec)]
+
         for fn in skiplist:
             recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
             p = recipe_parts[0]
@@ -187,7 +191,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                 # We only display once per recipe, we should prefer non extended versions of the
                 # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
                 # which would otherwise sort first).
-                if realfn[1] and realfn[0] in self.tinfoil.cooker.recipecaches[''].pkg_fn:
+                if realfn[1] and realfn[0] in self.tinfoil.cooker.recipecaches[mc].pkg_fn:
                     continue
 
                 if inherits:
@@ -496,6 +500,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_overlayed = self.add_command(sp, 'show-overlayed', self.do_show_overlayed)
         parser_show_overlayed.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
         parser_show_overlayed.add_argument('-s', '--same-version', help='only list overlayed recipes where the version is the same', action='store_true')
+        parser_show_overlayed.add_argument('--mc', help='use specified multiconfig', default='')
 
         parser_show_recipes = self.add_command(sp, 'show-recipes', self.do_show_recipes)
         parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
@@ -504,6 +509,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
         parser_show_recipes.add_argument('-l', '--layer', help='only list recipes from the selected layer', default='')
         parser_show_recipes.add_argument('-b', '--bare', help='output just names without the "(skipped)" marker', action='store_true')
+        parser_show_recipes.add_argument('--mc', help='use specified multiconfig', default='')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
-- 
2.17.1


