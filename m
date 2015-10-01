Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id 5E4BA770B5
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Oct 2015 21:18:14 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so87166829pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Oct 2015 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Zb7tZOJM4KP+F6fCny5JNUWzwpBYhfomRu6FfX/Dcr0=;
	b=HzRwsZsXxnOJANZF7SlQpp0pKCECSMmEzB/e01H7mWlCkpti/jRmvXsOT++ttC7X0J
	Az/J5nLh7hkK1m3C9MrHNJg7H6FQEs6nNPfDXR0ZKrPXkkOTjKJGkFm/Qd3mxB4CdfQy
	SqgJp2GCOegSa8EikVOvPZYr+cvOzAA6uqLAQlMUvfcJ/IlTHSujjxH9gFMh7rJAgmUe
	8r24ddN2t9TbGwBfnX6Uv1wtPvYs+CLKYV/IQR5tbzfngPjwHNIIl071mEeDsn2f0hrx
	Xc/NGTl06bkCLhRZfWagTEyrwZHasNL6gi7qfsk11FXKEy6G0IeDFJWFu5S/rTQJnK6a
	xrRQ==
X-Received: by 10.67.1.105 with SMTP id bf9mr15221793pad.64.1443734295022;
	Thu, 01 Oct 2015 14:18:15 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ej3sm8513411pbd.13.2015.10.01.14.18.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 01 Oct 2015 14:18:14 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Oct 2015 14:19:56 -0700
Message-Id: <4e02220a11fd454fc46c90d287ae3f3e847751b3.1443734209.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1443734209.git.avery.brian@gmail.com>
References: <cover.1443734209.git.avery.brian@gmail.com>
Subject: [PATCH 1/2] toaster: delete recipe if it can't be saved
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
X-List-Received-Date: Thu, 01 Oct 2015 21:18:15 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Due to Recipe model constraints some recipes can't be
saved. However, they still can create incomplete records in
the database. This causes all sorts of errors when Toaster
operates with those objects. Removing them should fix those
issues.

[YOCTO #7969]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 5aed158..89343f2 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1011,6 +1011,7 @@ class LayerIndexLayerSource(LayerSource):
                 ro.save()
             except IntegrityError as e:
                 logger.debug("Failed saving recipe, ignoring: %s (%s:%s)" % (e, ro.layer_version, ri['filepath']+"/"+ri['filename']))
+                ro.delete()
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
 
-- 
1.9.1


