Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9E8C77F00B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:44 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n4so4242231wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Nm5J7sDtj+8prUIHXwOz2mhP/57BmYVzkVSzy7e6MFc=;
	b=POnsFn2cxz8rxI6/V1JR6IXhIvG9X9pSb/QzP9dEwaZopk5dbTKZbw/AXSLCKx59ME
	A93mlFfghga/7+xT8rRDTQeNX7EG3dIIzPqUSkqsznByu41wtemZ7lGTygz/KN7Ty+VF
	6lheNPH/mVad2UpJtQeBw1AnjsPPoFZSzivM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Nm5J7sDtj+8prUIHXwOz2mhP/57BmYVzkVSzy7e6MFc=;
	b=ic7zxjVnZ0sU2PaCFGpU/1aZW+NFdE4CGGIS+yxWW914yuK8UZ8odOG+EQp6U8cYOw
	UWdu/0gGQx/RI6tNxYAvDrsGhzOFbp+BYkLyAXqqGcxAGK1z+qrUthYaA8SU7ZPMT5Mg
	1Do+m/KRHFkVuiPkGzDwea2ZHOO8wyFH0kCx3gwbqMUzGJ7KoUMsDpmALbEelWSgODwh
	DQm8aL9UG4KbJfYzcZD51ct+bFnI99s76LVEy6SNYrU6wnL631weXI0x3xH4lFU8OtV4
	sVe41D3roq9mNqsHwv0WVc8y/ObXfW8ucBGEkbUeLqy0sLk5xZAJY5/mbc5ZNFxRlp5B
	9xPw==
X-Gm-Message-State: APjAAAU97oG0f0MVzm1cZYFYXuyF8AvXy/Dv39oQPgFUlkbU0Tf2gV4p
	t/pZQh2QPW4mBJQs23fLPB8NagnZ/2k=
X-Google-Smtp-Source: APXvYqxtpb8csyor+pEKKBXe65tpQCwlKM76loi6tfdn6P52OxsRp8wpeQdbMDlIpeScQfVSj5jBMA==
X-Received: by 2002:a5d:5510:: with SMTP id b16mr219644wrv.267.1562802885087; 
	Wed, 10 Jul 2019 16:54:45 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.44
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:19 +0100
Message-Id: <20190710235420.23825-25-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 25/26] siggen: Fix default handler
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:45 -0000
Content-Transfer-Encoding: 8bit

After the unihash changes the default signature handler didn't work. Tweak it
to adapt to those changes (allowing the runqueue tests to work).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index fe580e487f..3b017219ed 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -49,7 +49,8 @@ class SignatureGenerator(object):
         return self.taskhash[task]
 
     def get_taskhash(self, fn, task, deps, dataCache):
-        return "0"
+        self.taskhash[fn + "." + task] = "0"
+        return self.taskhash[fn + "." + task]
 
     def writeout_file_checksum_cache(self):
         """Write/update the file checksum cache onto disk"""
-- 
2.20.1


