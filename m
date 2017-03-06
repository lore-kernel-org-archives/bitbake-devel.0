Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 296E0774FB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Mar 2017 22:03:50 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id o126so4710897pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Mar 2017 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fk8AQSQKPKej1EsvoEJAGg+gWnp5+YngnAFyXqSnu4k=;
	b=l+3lBc/qXUBvLkbelIK4QIYoU5f3GuSwrnGVXfCJOtO2ysrc9QENesEi3yX0Vpln9c
	lHbgTFDw6thXYgSpUvj+CYXW7bT76XRfePeG+DlZ8e5OZR2skZ711PyHQCdRH5gJiTOY
	Gje2GH16NpoRKsqQ8EsraSQEWBlOqgkwIetwmRjUm1W6STAayEBJuV2Bq9mbR5uxMxJ9
	8bLw3Z3E4gsNjdd+3DYgSQoPDLgwJO7HYQLkDqNp861g/Fp08TXlNn+d2SKSv7sECd1/
	CbevrfHuO2yIFARjlP2heA7iRdTUGFoFfFt1rCjjLsL+BkVPC6D6I12/byxJnXRKQ2QN
	czhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fk8AQSQKPKej1EsvoEJAGg+gWnp5+YngnAFyXqSnu4k=;
	b=ibrG1gnhHUnUynSWmBPDIJDyMicWjjivekdYO84waK9E0jGiLKDW5nww9dCnUHg9rm
	NMpKdX082dGJXYDI7DPDVpjb4/Frdc30KBoV2TJbSjgBfnsUF9Yoy/Uw/WXQvvDqO2ie
	Lk3172LCqV3kqS+y75EIKY0Rmx/kbqiqWvOG/AZ+uPUc8BIxEm70ZzDv66Qp4bqR8N+d
	l/HThYniR22shDeylzw5lb3tvm3KcgBtEc71FYTwPLvXePk4d2u1QtuuZOKXXmz7mY4D
	022IpiaUt2vil1qvlKAczF4O9uqdMzfsbtLxdp8T1iImZkWkuCN4t6JNFWJXQCXtpUW9
	wXaA==
X-Gm-Message-State: AMke39nXZ3pfHGRqdEwmvd8nj3K41/eqz2rVabuEYrRQS7arBZ09znjIjcB33NryVREaTQ==
X-Received: by 10.98.86.152 with SMTP id h24mr24311698pfj.184.1488837832312;
	Mon, 06 Mar 2017 14:03:52 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e76sm33312543pfk.75.2017.03.06.14.03.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 06 Mar 2017 14:03:51 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Mar 2017 14:05:07 -0800
Message-Id: <a61e4713f75e58548e34e9688bb275d195f9c5c7.1488837822.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1488837822.git.brian.avery@intel.com>
References: <cover.1488837822.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: resolve missing 'native[sdk]:' prefixes
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
X-List-Received-Date: Mon, 06 Mar 2017 22:03:51 -0000

From: David Reyna <David.Reyna@windriver.com>

Some task events are missing the 'virtual:native[sdk]:' prefixes.
The Toaster has code to help match missing prefixes, but needs
additional help resolving between 'native:' and 'nativesdk:', by
way of the '_package' event field.

[YOCTO #10849]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 5ed150d..92d1a1c 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1258,6 +1258,14 @@ class BuildInfoHelper(object):
                 candidates = [x for x in self.internal_state['taskdata'].keys() if x.endswith(identifier)]
                 if len(candidates) == 1:
                     identifier = candidates[0]
+                elif len(candidates) > 1 and hasattr(event,'_package'):
+                    if 'native-' in event._package:
+                        identifier = 'native:' + identifier
+                    if 'nativesdk-' in event._package:
+                        identifier = 'nativesdk:' + identifier
+                    candidates = [x for x in self.internal_state['taskdata'].keys() if x.endswith(identifier)]
+                    if len(candidates) == 1:
+                        identifier = candidates[0]
 
         assert identifier in self.internal_state['taskdata']
         identifierlist = identifier.split(":")
-- 
1.9.1


