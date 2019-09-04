Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id C9D647F29F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Sep 2019 07:37:26 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j16so20060936wrr.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Sep 2019 00:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=rWPhVCdKnOSZ2nR6UWYqfP2rw2FkcaVTXl0yUJPLIBQ=;
	b=Ujw/i4d8ro15SFXbJFd8asMX+ydB3/ei80aqdK74+PAdWukAFnHzck2GjnNfU/iZ5d
	LzAuv2Kb+aTx6zblkjHe+8AuiOUaDOP/BDuXVKlx4Tt4TKnhYkbxv3SRowYeOM2u/2SV
	H1bdT8iEGAMNbKlM6g0upB5NVG2INl5m2ZIcO2UhMVsOQwRQeZbm73KtpBpzh5d8yfKX
	kqXaHuSlnjuYeC8Z+AksL+gKirBScCtTIlcDtZvLtOOvkU2Tgxa86PGbKV6TP8d7n4Bi
	4igZX2vtWCh4XzAHiip3ebXg0b/rVwh43Rq7FdW8uCt2PCmg8JBPT+DmzGlbJ84+eR4B
	eSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=rWPhVCdKnOSZ2nR6UWYqfP2rw2FkcaVTXl0yUJPLIBQ=;
	b=SyG8mlNshRh9s7/8VfUPxC1To7cqO26ejShrPvANkjQ8Y5PuCpDwDyp02IUNO27iSt
	Enu0iKdZwd+KAqaqmfzrowwnnKxwDC8AdtK65N6Dk0Gh2K1IYaKG/cr+2RrBRG1UtWx7
	vyU3mKP90XRHfe2lOIRp1BioXDZE2phj9Xud04T3YpQ/hM//buJe6Tj1ISdkmgiVY0cm
	XzjcfCoNZMB+fniNfSg1tWF1Ymhh4igUED+RKGLYSuW8b15OHnRravBNcSnhG/Gawrjh
	s/FjwL9ovq/mn1Xf9pelCefF40roq1VMLMBAKlDWC1L6JTzLMN/BDUbLXHHI+jP9VyPY
	w5oA==
X-Gm-Message-State: APjAAAVpYPOpK8Pc6Tj6puc8J7hu1VsHEbObejmDdwYlBKpE9ZaziNXF
	CcqE3MZkMzCL1FnbTEPA2DiXBohKBi4=
X-Google-Smtp-Source: APXvYqxoqFTJq5cnzaMNh0sGzDpILoB1fmaXYTYFZUUFNVDVOdqnKlzBFjgCHW08ZUXfNmA31Bi7Rw==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr44593524wro.47.1567582647242; 
	Wed, 04 Sep 2019 00:37:27 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id f15sm2964718wml.8.2019.09.04.00.37.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 04 Sep 2019 00:37:26 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Sep 2019 07:37:27 +0000
Message-Id: <20190904073728.2567560-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.42][PATCH 1/2] utils: Fix movefile() exception handling with python3
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
X-List-Received-Date: Wed, 04 Sep 2019 07:37:27 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* with python3 this fails with:
  File: 'bitbake/lib/bb/utils.py', lineno: 799, function: movefile
       0795:        try:
       0796:            os.rename(src, destpath)
       0797:            renamefailed = 0
       0798:        except Exception as e:
   *** 0799:            if e[0] != errno.EXDEV:
       0800:                # Some random error.
       0801:                print("movefile: Failed to move", src, "to", dest, e)
       0802:                return None
       0803:            # Invalid cross-device-link 'bind' mounted or actually Cross-Device
  Exception: TypeError: 'OSError' object is not subscriptable

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e4386940..7aaf9309 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -782,7 +782,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
             os.rename(src, destpath)
             renamefailed = 0
         except Exception as e:
-            if e[0] != errno.EXDEV:
+            if e.errno != errno.EXDEV:
                 # Some random error.
                 print("movefile: Failed to move", src, "to", dest, e)
                 return None
-- 
2.17.1


