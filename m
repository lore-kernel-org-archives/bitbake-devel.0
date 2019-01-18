Return-Path: <kergoth@gmail.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 368997C275
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 16:46:06 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z5so15805190wrt.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=jjYvSYqufWqbIMEEYq79c3H43v8l4mhlk8fqy8GLx7s=;
	b=Wqwp8UY0vk5oib4WvXx1W7bMXIQhMZNYHi6LJOnviE77nEu3r7SkgqRcCCSSWl6Me/
	BMnyi+dwrANeK8EDeUayC/anAAJK1CpZ0upT2yI+0Qe6CeFM9ep7cGTaXfne6yBN6QIP
	/CXBV9+21kP/fcrj9F7vzNPfnUJIQWd1wVoaeLx3fg/gf1rkfsGjGbzqFwsbKo8PCl/J
	FIZELaaWF9piMkuk2JGe+olJQMiwNdf6epEG8kIhPotOTn/bo0Sfv6+SEqMtPdnBtsyv
	L9KbLStaPDqUx9P29s3wnLaJFqPF4CsMHcxe7l3ms8MhVJv9+h0ocb3PSOPXg0fOgeU9
	VIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jjYvSYqufWqbIMEEYq79c3H43v8l4mhlk8fqy8GLx7s=;
	b=LTpozu7BOOUFCi3T9y5Ps8fayaozm5ju9cvJiREEsJMJ9LCm6uScvKeUbN2NZBTYYD
	GHPl4FRDpBKtSYI95khm9UDSKlQme41ReZ6Jsm7FEv4hKKDTXan1H5yJC2lTJ1Fe0EMM
	qhQWfNjr0suYDZHRPSeA7cEOfJzfyeOtRqHQfFybXC7izRayAlw16pfeX+9qESa+Nc3V
	IhQqEVCclD06ksyVI3LofV0F9zJNTGG6XxY7uFPaZ9mXZ/0PtukORZ9wZ8D/kSlVMSER
	AsnnTuutLUmwdqkQChUiUPok7HYwHbxdzP+J26yYiY9vOFqMu3e8C6Yg/Mmv3Z03OicA
	vAZA==
X-Gm-Message-State: AJcUukdk0VNaenfOFKlMjOaZoS4zp0fQqGd+fgT6TDCmVVf4PvGfV42G
	5L+tiW8BmG1toxWqZHDIzWbqd4UD
X-Google-Smtp-Source: ALg8bN4lFHA0OZewhkrcwpwXwQbmmDViiuWFh8rNL7+bSwdRqDSWaCMJmGXeEn8KEHBoCYIvGDz+IQ==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr17831742wrs.272.1547829966695;
	Fri, 18 Jan 2019 08:46:06 -0800 (PST)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	b7sm78523175wrs.47.2019.01.18.08.46.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 08:46:05 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 18 Jan 2019 21:45:55 +0500
Message-Id: <9cb64e9781c98f1aaa42571af54655eaf6816583.1547829050.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1547829050.git.chris_larson@mentor.com>
References: <cover.1547829050.git.chris_larson@mentor.com>
In-Reply-To: <cover.1547829050.git.chris_larson@mentor.com>
References: <cover.1547829050.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] bb.tests.codeparser: add parameter expansion modifiers test
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
X-List-Received-Date: Fri, 18 Jan 2019 16:46:06 -0000

From: Christopher Larson <chris_larson@mentor.com>

We don't want references including shell parameter expansion modifiers
(i.e. `:-`, `#`, `%%`, etc) to be added to our vardeps, so add a test to
ensure this.

YOCTO #12987

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/tests/codeparser.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index e30e78c1..3fd76a8f 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -123,6 +123,13 @@ ${D}${libdir}/pkgconfig/*.pc
         self.parseExpression("sed -i -e 's:IP{:I${:g' $pc")
         self.assertExecs(set(["sed"]))
 
+    def test_parameter_expansion_modifiers(self):
+        # - and + are also valid modifiers for parameter expansion, but are
+        # valid characters in bitbake variable names, so are not included here
+        for i in ('=', ':-', ':=', '?', ':?', ':+', '#', '%', '##', '%%'):
+            name = "foo%sbar" % i
+            self.parseExpression("${%s}" % name)
+            self.assertNotIn(name, self.references)
 
     def test_until(self):
         self.parseExpression("until false; do echo true; done")
-- 
2.17.1


