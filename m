Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoiFZ-0002ql-84
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:45:41 +0200
Received: by wibhm2 with SMTP id hm2so3632866wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=EMcN/1nKcFsMJq7hghLdJ+AXB1CBokewMdLR9gOwOBE=;
	b=Sx0gVSSJcJwyMrD230VwotBrEdCYuZvuz7z4ZuBpCWEeeyVFW/QPKVXA7KB+zR8KBQ
	FNh+/9xEQjhZBvCZqy+P+EKOKSLx1Yowsxm5xFi7tTTzoxx80l6dzSELoXgY7RRWi9Gc
	IOvzTyM29uZTdtadMhYCNZpzhPW3NvURy+ppHgQnBSNuqZK2iTaJ92cgUPusvtQvQ7W8
	HchhELbgeIuZioVXKRCslUt2KkDBgUFlfwE/TYz0/oGdkM2G5TBUFBYqanloZ9XgSdds
	pRRj4bh4J8ysEFjAXnY/v2eRUZBJl87HRnVTZx6Pfo+YVuOOOmebeIdSAtYQlhXsalfj
	YexQ==
Received: by 10.180.107.70 with SMTP id ha6mr41393334wib.16.1341956070450;
	Tue, 10 Jul 2012 14:34:30 -0700 (PDT)
Received: from localhost.localdomain ([79.117.115.156])
	by mx.google.com with ESMTPS id bc2sm46013474wib.0.2012.07.10.14.34.29
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 14:34:29 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jul 2012 00:34:17 +0300
Message-Id: <9362ec74cf7c182a17e7e23d99f2a934f9d8a8cf.1341955881.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
References: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341955881.git.andrei@gherzan.ro>
References: <cover.1341955881.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQmQj/qk+F5bxTdVXIif9koAdTgqMrlR4vqe2xf8Hb4H8uxLl2dnD4YSnNwJZZ5X1N4ptzVO
Subject: [PATCH-V2 5/5] fetch2/__init__.py: Warn user if SRC_URI is using "proto" and not "protocol"
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
X-List-Received-Date: Tue, 10 Jul 2012 21:45:41 -0000

As well, if "proto" is used, get the associated value as "protocol"

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/__init__.py |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 52e12a0..fa963be 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -755,6 +755,10 @@ class FetchData(object):
         if localonly and not isinstance(self.method, local.Local):
             raise NonLocalMethod()
 
+        if self.parm.get("proto", None) and "protocol" not in self.parm:
+            logger.warn('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN', True))
+            self.parm["protocol"] = self.parm.get("proto", None)
+
         if hasattr(self.method, "urldata_init"):
             self.method.urldata_init(self, d)
 
-- 
1.7.9.5



