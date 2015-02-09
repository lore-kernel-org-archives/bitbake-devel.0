Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 56E86732D9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:16 +0000 (UTC)
Received: by pdjy10 with SMTP id y10so10229346pdj.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Fo185cPBK8bCKChEX+BCP2r7OzWVnQf7rW0XQj2bh6o=;
	b=Bhm7rQ9GjlkXRsafZJf7FB9Siu8KLyuQT/HaJ37ZiX6w090XpTeARIPiCuOMJXtYSR
	mWNrBksMqpbVBcj1e+lgNuDkqIs7nCS2913TdN2JmLg+ZfiuBa3/hzR2UsxuViWWMWu1
	ust1MNhOVJlOg9n6gIGa4T67hWwSHn8Y+4jDt2dmZKA7jciKxW6ZuH60bgnA2hOecS5s
	DA8VrA+z8IPGX10Ji2/kVHNfIaZ+GiuoGhUU1RbRI19IZ9Nz+GMW3lQ5CNKiNYWTHAXq
	OiGcA7uYyZbvaFIyn0YxKhMTMDeP00/hFlDs5eWYE8vkkqlbe2QxADAZe7CJ+p2kaJQB
	bIsg==
X-Gm-Message-State: ALoCoQlD2YbBeZqckF0THE1TD9j5y+LECjHZyjjprXemsjNaxJfVSobhAyB8Vyet+6JJ5VU3Ddtk
X-Received: by 10.70.102.35 with SMTP id fl3mr30716197pdb.30.1423504937743;
	Mon, 09 Feb 2015 10:02:17 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	go1sm16268466pbd.75.2015.02.09.10.02.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 21BFB56618A; Mon,  9 Feb 2015 18:02:15 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:54 +0000
Message-Id: <fcb551ff622b3b24ee113ad49ec6cbd26569acd0.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 24/27] toaster: All machines reset order_by if removing that column
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:16 -0000

From: Michael Wood <michael.g.wood@intel.com>

When you remove a column from a table that is currently being sorted by
that value we also need to remove the sort.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 88d59f4..255b6a3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2846,6 +2846,7 @@ if toastermain.settings.MANAGED:
                 {   'name': 'Machine',
                     'orderfield': _get_toggle_order(request, "name"),
                     'ordericon' : _get_toggle_order_icon(request, "name"),
+                    'orderkey' : "name",
                 },
                 {   'name': 'Description',
                     'dclass': 'span5',
@@ -2855,6 +2856,7 @@ if toastermain.settings.MANAGED:
                     'clclass': 'layer',
                     'orderfield': _get_toggle_order(request, "layer_version__layer__name"),
                     'ordericon' : _get_toggle_order_icon(request, "layer_version__layer__name"),
+                    'orderkey' : "layer_version__layer__name",
                 },
                 {   'name': 'Layer source',
                     'clclass': 'source',
-- 
1.9.1


