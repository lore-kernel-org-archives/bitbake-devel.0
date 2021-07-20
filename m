Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
 by mx.groups.io with SMTP id smtpd.web10.158.1626801397184502275
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 10:16:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=NR7nTCSo;
 spf=pass (domain: pbarker.dev, ip: 64.147.123.24, mailfrom: paul@pbarker.dev)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id AFB783200932;
	Tue, 20 Jul 2021 13:16:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jul 2021 13:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=fm1; bh=ZSET/zc88suPg
	2ZnTfmPaYT1jlePH4P2Ep/lV7Kwibs=; b=NR7nTCSoNjlRbtHGNjaIJp42cYGwh
	Kb/+6Y/knKWOYvbDmD+nTrB+1UDp8AFkWNSyZBAAL3QvcCoS8mypZVNppG4qMxRe
	ZKz+x9+NX/i160qFRiAyug69/Ved154Fy2HrtDOheB9sTJEyIOERvhIqtiAs7Ymf
	2Le2+9MqJEy6vszKi+S6/eeFOVorwHISIg6VtO7/eANrPzsQiAFsw6u3hVVoiojY
	7cO9U9l57ywvhgwClLtm+gly4ZnAiyqskR8iZt6GWYm0gtXz1YPTQWyEzl+Ar2ga
	Id6mW9qp6tHD6ML61p7hIKzezBfZBzib9w3qy0vs0VnsDg6akPpBag1dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; bh=ZSET/zc88suPg2ZnTfmPaYT1jlePH4P2Ep/lV7Kwibs=; b=n0vnXefq
	52K/AlUASTLf/VS7clITuOPFRER70SjUMdvkB3rnifNhs/DC8SW4iomW5nijvQcD
	Jy38uwGm43u+AQu/PbVnA8ka6kAlafwi7RDkJ32cmYmevHJ9pgsG4CemYPM882fy
	39nrX/CI9XQVEXBTSKevaQiL3QsdQDZ3JIj1ponw4AuMIJwFq598m3AbkgVo37P4
	lHlwDvobAbmE3fRYrzXjhA+PEx7Mc64J65tGl1LMDYD/CB/WV3FPETD8cCFWVBH0
	jCKo+Q/v3/k1eIMnFR7TJ7J5Cm+KMeY2P5Q/UeINeuvlEdw6j3CGMb8pj3fVQV+6
	+b+upnajUbmKJw==
X-ME-Sender: <xms:9AT3YPMFhdTHXQZbHMN7K3qeZ51_nnZcZiEkGjUELsCv_RvF3DTPng>
    <xme:9AT3YJ_29X3YUw5qgZBjUWNcijMUnxo42VP0QhyTMhiF0rpmTbZjC6WLSWe17ZfYj
    qObnS7X8Kg6ux9mtvk>
X-ME-Received: <xmr:9AT3YOQzQdHFPvo3M-ccBjJoGDANqnaQBn8zg0ROJLe6qbHcJcvlX30yxv4_qNgcxG7tQCv2u_SHIwvasMSXbRAabS-Xc_i1yzzNFlTaWpePMHibpXwmWB4coPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgv
    rhdruggvvheqnecuggftrfgrthhtvghrnhephfelvedvudejtdehgfdutdefkeffffduvd
    eiueelteetfeeltedtfeegteejfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
X-ME-Proxy: <xmx:9AT3YDtcdYDs8x3RgrQhXJUkvDerdOZNyK3qyjGxAe2mHDRXw4cytg>
    <xmx:9AT3YHcLfY8rDJ_Nb2X4VmXPRR5NUKjm749M-8pJUhLgGlQcJ55dNg>
    <xmx:9AT3YP1nJbWCiy4QqcNtZhLn5pDw0zGcU9JmQjmUmHM4kJEg_OfpWg>
    <xmx:9AT3YHlp47x1oAiH8z1ZqE7O805R3OTCWqVRgdO-CsaSsIM_SkgWtA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 13:16:35 -0400 (EDT)
From: "Paul Barker" <paul@pbarker.dev>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
Subject: [PATCH 1/1] parse/ast: Substitute '~' when naming anonymous functions
Date: Tue, 20 Jul 2021 18:16:28 +0100
Message-Id: <20210720171628.23394-2-paul@pbarker.dev>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210720171628.23394-1-paul@pbarker.dev>
References: <20210720171628.23394-1-paul@pbarker.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing an anonymous python function, bitbake generates a name for
the function based on the full path to the file in which it was found.
As not all characters which are valid in file paths are valid in Python
function names we have a translation table. However, this translation
table was missing an entry for '~'.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 50a88f7da7..743ea0dfc0 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -145,7 +145,7 @@ class DataNode(AstNode):
             data.setVar(key, val, parsing=True, **loginfo)
 
 class MethodNode(AstNode):
-    tr_tbl = str.maketrans('/.+-@%&', '_______')
+    tr_tbl = str.maketrans('/.+-@%&~', '________')
 
     def __init__(self, filename, lineno, func_name, body, python, fakeroot):
         AstNode.__init__(self, filename, lineno)
-- 
2.26.2

