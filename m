Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C9CCF9FE
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:55:20 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4028.1761998687539148713
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Nov 2025 05:04:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JEIbs7t9;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1865897f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Nov 2025 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761998686; x=1762603486; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO26pF+bm+/vhWyIgoAqOgU82NbS28bvGv9ePq4MuP4=;
        b=JEIbs7t9xCYhuBGsWPzW4nqAX+uh5XmyFaEtfw1tmsri9TR8t0JXNfrQUp+qkBU59t
         Tbejsm/GAYJWRpXze+m5IJgvCRkn2v3nzIN0PCm/sA5g515TiQIYIpjUxaei2Z1vc9kz
         s8Lb1K2d+1qZpB9P/1q0YwRjczFoVFNJbMt91wGmzCfnQ84k7prZ8+EsMWCOlhOysC9C
         sNeW9SEdYb7Yzl/9u/amnOzxvOBQ7xi5TOszsDqwasHIj1keBk0V2szitA2QTjQ3C+eu
         IfyvkYruiiTkjVLcqevrQQpO0P3oGshfBuF6BKhMkH/Q7R39SsBfOGZAFHXNQGfXrKi7
         9+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761998686; x=1762603486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO26pF+bm+/vhWyIgoAqOgU82NbS28bvGv9ePq4MuP4=;
        b=r2TOHnPfQjWlbCJG1Nex2BDIN07lH04ppq0Wo76JsylRhP+O5qT/KQdllv5dEOe11c
         fMtmqQwKlFQKcagSZv55sVSyhqkT2Ov90+fYCrZCGYJjEGhWR7/t7XmKJKFtR2MXeKy8
         hKDnXCL3+767yt38YXs+0PGZ5KeThUUoP8iogwgb6N3CgY8vEhxqm83MnP7qEG9t1QDP
         4dmqf9dsb0553l2grnshbirUc4WImNiqzqi6CzruW5wvbeGRGXqbFHZLEIVqmMC4Kz/H
         WFf2y4LDl3pj6Xz9W62BIkticZYkvLwDR/oozyzOIJFOsJBsi4HD/EBeyPh7ddhZDxZR
         GV9w==
X-Gm-Message-State: AOJu0Yx8v3E0VR3VO7ytQ1y+wxwFiW3cyCniDQrmE9RRlx9AcWWFeQEj
	03qwjhab16zU6YUnKG0wxUtoZoT454jXx/8rxfAuO5cbhzEn4J8gSWFPxHqvmQMZ
X-Gm-Gg: ASbGncuzQU4gol0r+NopzCfM4uiby8J+2eKQ9br98hayxetTgrwPUdd8pmiw8Gs0tGM
	c0U6+aL0UilsOR57LaQ0lVjwGwrqvTKKyRapmh0rsuCLSJBQuf1/jLV30T1girpWUHAMKbT1t6i
	k06rteD4Z3u0b56OIUhe4R/upT4ZtuS+X06EqbrB0aUHp9glQraXjPJ6L8Mglk5vbSGmJN32B9M
	ICWF+bGhrsJF4tQZkWMh52StHrxIcQllOTUfLTcr/vnaS1MgofTuzkdzvYllUreIIq5qybTNDs8
	JieXg1n1BPDVn6oR1ElT6cFpD3YLu/LvQ57aKo+yC8HomUp3A7omAE3CZeInpkEmNOJGFT0FqAD
	vnpd33hmY0jn5hbaSB4BymAQGEGw8tMQU2MGp3LxG28Nw0OmGiBbB39aqBKfFQIEKk3A3tEsAvy
	7LtnLDdgYlDQVEGKfxEyYqbUey
X-Google-Smtp-Source: AGHT+IE7ctp+vlTJCKx6xnlvunDsf6kcA0VmR2vgzBtGitdAOVgylvn2AWivoPlDv7HIA/SCv7oKuQ==
X-Received: by 2002:a05:6000:1849:b0:429:8b44:57b7 with SMTP id ffacd0b85a97d-429bd6e16b3mr5696961f8f.51.1761998685424;
        Sat, 01 Nov 2025 05:04:45 -0700 (PDT)
Received: from osama.. ([197.46.180.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fe402c5sm39875285e9.14.2025.11.01.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:04:44 -0700 (PDT)
From: "Osama Abdelkader" <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	ross.burton@arm.com
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] bblayers/query: Add --show-variants option to display BBCLASSEXTEND variants
Date: Sat,  1 Nov 2025 14:04:16 +0200
Message-ID: <20251101120416.9569-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 11:55:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18235

The bitbake-layers show-recipes command was hiding BBCLASSEXTEND recipe
variants (e.g., devupstream, nativesdk, cross-canadian) by design, to
avoid clutter in the output. However, this made it impossible to see
recipes like linux-firmware's devupstream variant which uses git snapshots
instead of release tarballs.

This patch adds a new --show-variants (-v) option to show-recipes that
allows users to view all BBCLASSEXTEND variants when needed, while
maintaining the default behavior of hiding them for a cleaner output.

Example usage:
  bitbake-layers show-recipes -v linux-firmware

This will now show both:
  - Base version: 1:20251011
  - Devupstream version: 1:20251011+git

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 bitbake/lib/bblayers/query.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index eb7cb465b4..11341d5d53 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -52,7 +52,7 @@ layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
 """
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None, args.mc)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None, args.mc, False)
 
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
@@ -119,9 +119,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
             title = 'Matching recipes:'
         else:
             title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, args.bare, inheritlist, args.mc)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, args.bare, inheritlist, args.mc, args.show_variants)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, bare, inherits, mc):
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, bare, inherits, mc, show_variants=False):
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
@@ -203,8 +203,10 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                 # We only display once per recipe, we should prefer non extended versions of the
                 # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
                 # which would otherwise sort first).
+                # However, if show_variants is True, we show all BBCLASSEXTEND variants.
                 if realfn[1] and realfn[0] in self.tinfoil.cooker.recipecaches[mc].pkg_fn:
-                    continue
+                    if not show_variants:
+                        continue
 
                 if inherits:
                     matchcount = 0
@@ -229,7 +231,11 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     for prov in allproviders[p]:
                         provfile = bb.cache.virtualfn2realfn(prov[1])[0]
                         provlayer = self.get_file_layer(provfile)
-                        provs.append((provfile, provlayer, prov[0]))
+                        # When show_variants is True, use the virtual filename to distinguish BBCLASSEXTEND variants
+                        if show_variants:
+                            provs.append((prov[1], provlayer, prov[0]))
+                        else:
+                            provs.append((provfile, provlayer, prov[0]))
                         if provlayer != preflayer:
                             multilayer = True
                         if prov[0] != pref[0]:
@@ -238,10 +244,12 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                         if not items_listed:
                             logger.plain('=== %s ===' % title)
                             items_listed = True
+                        # When show_variants is True, use the virtual filename for preference check
+                        pref_cmp_file = pref[1] if show_variants else preffile
                         print_item(preffile, p, self.version_str(pref[0][0], pref[0][1]), preflayer, True)
                         for (provfile, provlayer, provver) in provs:
-                            if provfile != preffile:
-                                print_item(provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
+                            if provfile != pref_cmp_file:
+                                print_item(bb.cache.virtualfn2realfn(provfile)[0] if show_variants else provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
                         # Ensure we don't show two entries for BBCLASSEXTENDed recipes
                         preffiles.append(preffile)
 
@@ -530,6 +538,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
         parser_show_recipes.add_argument('-l', '--layer', help='only list recipes from the selected layer', default='')
         parser_show_recipes.add_argument('-b', '--bare', help='output just names without the "(skipped)" marker', action='store_true')
+        parser_show_recipes.add_argument('-v', '--show-variants', help='show all BBCLASSEXTEND recipe variants (e.g., devupstream, nativesdk)', action='store_true')
         parser_show_recipes.add_argument('--mc', help='use specified multiconfig', default='')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
-- 
2.43.0


