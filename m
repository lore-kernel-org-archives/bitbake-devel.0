Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFF7F3C26E
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:12:47 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15234.1773065564647504572
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 07:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MT0QdBoj;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso7748885e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773065563; x=1773670363; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAy3nmQE5PuWfBeQVBJnLnSRjiZ/1N4PeiBcKGGzkLI=;
        b=MT0QdBojaCtF0B7tK6oYIIjNobnJEpCkVROVA+siwoT0Eh/+kKri2OBRFP3lqBVuLT
         nmhU+CPG56hyBtwBasMsne+IGOLoBPrNaDKqboAdhXLFk+bf3nzF14MIjdo9aXtS9SSg
         gkyFzJ5H4bFty7S1oqOUZZnqaKHLdHC7caELxNKrXwOrARJ5bEERvAvkETN9S4ROaOdg
         NZGOUta4a+6QW0MfmJKy/fLWtK7IrOEOtHRw7z5fxSNqbMZQh5C8xZqLHl+M/E2GIL80
         cBh+YlzxiSqHdXAYuQhzN4Ozj8feffngR1MiZWFi57Wv8k+I8UZGY+1FYsx7jNJxKG6C
         tkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065563; x=1773670363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAy3nmQE5PuWfBeQVBJnLnSRjiZ/1N4PeiBcKGGzkLI=;
        b=aWCQ3j5iSDJmCZ4h0zTo+9CVjkftKiKMzvh5YcYhxYXjmB/v3A4Va/XbHWN3NHs8Hg
         L1VlMMcz//mUYdoAklpA/VdTeFbndHYf4kG6rW8DuKNZvkuhs0KTwaQ7caDeqv8lhTg6
         JSkFSF9gWl/P7iR5BVUNlbNCM1aDKmVOrQ96vOyJ04IsqaGAd1tK9eCGI4ciMPkbsB91
         lo7nkKN0vzPAQyx3lhu+GRwjTl+1xbR8Tu/GQRwCMUnjtI+72XazCP8ph9sR6wWr4S5c
         S1zyiqlKkD/40/v2N5L3qYJLrkJDnUrIrRH63nlcteUwc3WNbyjjk/xBVzO1BF4EiIh7
         Scuw==
X-Gm-Message-State: AOJu0YwQ87fuQ1uGLc33oL2UxzXOMqdFkdmNZsy/B4x0TdD87XbuFlRQ
	77aMszs5F1b8cuzfjPvVN+H0GQmXDynQwsHt3NX/5OwoyrJczj4+2apgeQ8L3g==
X-Gm-Gg: ATEYQzyE58QjtlYKShJdmEQKwdsHmktvvlkkMv9CGAAJxwrPLwtaI5nmT/O9RzBfimW
	Vlv+m9Vl0sLUUpUjV7cARRwfOQ4WjSgWEtsx/0oaGyOLopyDSSF3bAFgSaigthUGVhhVWiigp9U
	P217eSq1hTkY34yViemP6SZM9jFKZJqKNpV/fwLHnjFpSwQfBF2XrKNVzGH8pju07aLbjsSnfzQ
	sFNr5sXmex5tYrOKziEr6qYaPm3YFbU2glQQOLXF1mnEy5sbOUTTv16TV3erKI0V2d0JUTXaqnI
	9DO8xLC7XX1OeyHSObd68C/nvE60TsSz+42pa+pomV3620J/J8Fa3X/j0haw9Y3PG3bjXLF3+hW
	w5/280CyxLgElvO7mHb0cfYNWchtth/5i4KbClnWe2fu87KjRZPvkfQFNYjipcpVL1S0LTYMCGq
	G4GQHl9ogPKyw2EUhG7EiMAwZP4azgFJ3Du17SbmAdWjWLYJqOk+nrjLDz18g=
X-Received: by 2002:a05:6000:400e:b0:439:b0ed:2afe with SMTP id ffacd0b85a97d-439da348192mr17895753f8f.11.1773065562594;
        Mon, 09 Mar 2026 07:12:42 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm25443458f8f.3.2026.03.09.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:12:42 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 2/3] bitbake-setup: are_layers_changed(): calculate local_revision only once
Date: Mon,  9 Mar 2026 15:12:37 +0100
Message-ID: <20260309141238.1785102-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309141238.1785102-1-alex.kanavin@gmail.com>
References: <20260309141238.1785102-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:12:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19125

From: Alexander Kanavin <alex@linutronix.de>

There's no need to repeatedly do it in the loop, as it doesn't change.

Also reposition 'remotes' and 'changed' variables assignments, as this will aid
the code readability after the following commit.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 54f2015a2..19a6b5373 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -742,12 +742,14 @@ def get_diff(file1, file2):
 
 def are_layers_changed(layers, layerdir, d):
     def _is_git_remote_changed(r_remote, repodir):
-        changed = False
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
 
-        remotes = _get_remotes(r_remote)
+        rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
+        local_revision = rev_parse_result[0].strip()
 
+        remotes = _get_remotes(r_remote)
+        changed = False
         for remote in remotes:
             type,host,path,user,pswd,params = bb.fetch.decodeurl(remote)
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
@@ -756,8 +758,6 @@ def are_layers_changed(layers, layerdir, d):
             else:
                 fetcher = bb.fetch.FetchData("{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir), d)
             upstream_revision = fetcher.method.latest_revision(fetcher, d, 'default')
-            rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
-            local_revision = rev_parse_result[0].strip()
             if upstream_revision != local_revision:
                 changed = True
                 logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remote, os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
-- 
2.47.3


