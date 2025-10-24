Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED88CCF9FE
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:55:10 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.14611.1761319753040507160
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Oct 2025 08:29:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b8j4SpQw;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso1111302f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Oct 2025 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319751; x=1761924551; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO26pF+bm+/vhWyIgoAqOgU82NbS28bvGv9ePq4MuP4=;
        b=b8j4SpQwEXmYk14Cyxd2IcuXJNVlyCdzn7d1UNZquUjKmtHTpM/a/iGpiS/sFOesLJ
         lqdnLz82LvQOg/KT8My6D1JLKQc1btbVnZoqNTAVbRzM1trJLybLECOHA121nYAeyw1T
         d//PrKudsUY4bGoLeJ6n1I1nzRH5MbJVrt62d7g186N7EehmZnAcNAcK3NNETcU8MNgN
         Sg+vjXhjYwAZ5Tansh8pjXKXHT3JYOPhIKGVqqqhVuGD8DWZfzp1sILL37xYVrhZOOyB
         dQcEnruKG/VXsgVFOadesjEf2t80q3GEhu7snhjXLnh7Cf+tdphPIaNQWurvnNfVYuCW
         EKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319751; x=1761924551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO26pF+bm+/vhWyIgoAqOgU82NbS28bvGv9ePq4MuP4=;
        b=E7FarwLxL7OePjovGwm4bYcLOsGf0Qy5mQ1GgXzSRLpT1eG4WHwkbApQwxMtESvPSs
         TrIT7T5POoyT7lrFPApyCxgGN58Kl0AVyMNXr64o8Pg3VmDKvcTAPlLwSg0VGZaeRMV3
         zgepwlc5owrGV+/2JsafoYueFT3zur3FTbNahP9sWtWIIkWp5TSGz5BQwqolQKbt8xUc
         3LdvoeNKFsEv+D/JqYP77ueED2kPQMGBgrtn4BN7Uv9i0YNWaKtWeiqsiq39rrRraFbK
         8q7Z/w64mEwmHljFVHGa4/oD9nkzU3LG2WJ1+jayJCoNeZWf81tKx9DmqfOFwdC92Fi9
         sTRA==
X-Gm-Message-State: AOJu0YyqYK4u0pDXMKtfEOWIuPJDEU6CIjCe6WbRw1GPVKk5mtutMY0X
	/5ZL+pHrFhHs46nROGsF/z2jznb9pNltfugimt3O2iuoJjiiwHOEkxibYFlwb42y
X-Gm-Gg: ASbGncvJZ/I3Sm6Q9WZh9PTTTjhFl9+x5UaUzpez9xMAAkmKZoKrzNQqXEO99tec89x
	J0AzjdT3pEXvxJryfdtWglJof3p6yWMUdgr6pl+fmmHZJ5lMhLp9Q5FVLsK5A2f7VRnGw8DMEoJ
	YvM0d/Vcv4UNbN9QkmAXAwcrQoDR1XniGNvPTDLTBP4zGwj/f+zCiPbo1mGAg0BVyJUTRSd+EOq
	0scTABYxw5UlIswZCDpO4LBoIZzNHPlymL5A9MfTohO1i4hKv4uF1OiKDPIg3PUo+qbTZemRyoZ
	OKEqGrVGeoq51HFBQ4sAkqWvEeEwQ0d8qxs8FPnvfu5ykLBdBcLZhjKhs8kZxEWIHB4DpCIi3J1
	aVPgsQ5a1NUudSg2rx0j2+1c8mcmK6kgNUcKoCVPIn2BnU+edwl/dk6jZxsHrUkIJDFWxva8i7S
	Vx1w==
X-Google-Smtp-Source: AGHT+IFriLimAYsfNtTX7LIkwmSnR+74qkdI0oHXwftMnEU38+OKhZSaqn0+EmcjXjlI3wtIgCSIsw==
X-Received: by 2002:a05:6000:400e:b0:3ec:c50c:7164 with SMTP id ffacd0b85a97d-42704d52205mr21088335f8f.15.1761319750994;
        Fri, 24 Oct 2025 08:29:10 -0700 (PDT)
Received: from osama.. ([197.46.164.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298b9963ccsm8215283f8f.7.2025.10.24.08.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:29:10 -0700 (PDT)
From: "Osama Abdelkader" <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] bitbake: bblayers/query: Add --show-variants option to display BBCLASSEXTEND variants
Date: Fri, 24 Oct 2025 18:29:06 +0300
Message-ID: <20251024152907.18547-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 11:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18234

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


