Return-Path: <jpuhlman@mvista.com>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id E46C777F6D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Oct 2017 16:43:58 +0000 (UTC)
Received: by mail-pf0-f180.google.com with SMTP id g65so6518961pfe.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Oct 2017 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=B/ZYQf5T4vfrdcG3UJ8kt5QYVRuNfduaw/e+C5EPurQ=;
	b=k+Ew4CKKBnqOeg9nP1BWA2KB9RCchhyDGJGZrCmQh8TxjR0sFacXg0/HfAHws3oW4/
	/pp77clvOO9HMZgnLVNXEiKdoPxCSehlNYm33exnC1MImgO7WDeKHe+at6MboyNqgWOH
	0jB5+X0CfQw4xgEW9XTBiqQ3iPTB28QwwOdzdkXJsh1hCoPhupra9gQoWgHIOj4ytRo1
	L5iig1VoUn3yRkpTpzdv3EIYC4qESRiy5RlDTQ6Kf/e7155729YTUOAGQEafd8+3EjJ0
	w8S7tOUyzI08soe7coa1z0oVN3YxVXn+tuOvR6ULFagnEjFpUKBypaDtE1UnGoMif8Er
	/ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=B/ZYQf5T4vfrdcG3UJ8kt5QYVRuNfduaw/e+C5EPurQ=;
	b=mgqS+KD656ne1XEC87gJUc00gXoyt03D8PalPlc3+yPHjIdNXdi0XchhRGWsBsXr67
	PInTFMvQ/ZcIBEvaSk/Q0hwSVsIEn1A7ijl41Iwgqwj3Dm1I+b8fQFbdEKcCPogDf6Gs
	3APNEU/Bor0itchTqu5Dcx96O5m5Vt2k1E+PCGEu7phRx9zYTLDhFn+eSgd9KGGcUWfV
	6/I2zxgbInq2I8Ox4Qf0rEfamFbGkZl6GQpYWQtmECg823zAd7xJPo+YxJMGL3morLni
	uP0pe8W8iqjoYMqlPD+4XDaDPUXA54MjEeR2UZuFoWSLOmcubkm1MAz1O0GLcAGuZo7p
	o4Eg==
X-Gm-Message-State: AHPjjUjkHyO7ENzv1iwToIDvtOVFzMIKl2i10q3KzFJUqzAymR4qWX9R
	uDODqjkq11xJvUq9i2IEy6l1Gze9
X-Google-Smtp-Source: AOwi7QAkxO1yK8OKSF+lgurHxLnAJSQnffQq1l0xVRHxieUi021DUklc82CGli0MW/NbxjvLVY8brg==
X-Received: by 10.99.148.17 with SMTP id m17mr15829243pge.114.1507135439765;
	Wed, 04 Oct 2017 09:43:59 -0700 (PDT)
Received: from workhorse.mvista.com
	(99-0-9-164.lightspeed.frokca.sbcglobal.net. [99.0.9.164])
	by smtp.gmail.com with ESMTPSA id
	y79sm21527564pfb.12.2017.10.04.09.43.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Oct 2017 09:43:58 -0700 (PDT)
From: Jeremy Puhlman <jpuhlman@mvista.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Oct 2017 09:43:45 -0700
Message-Id: <1507135425-15921-1-git-send-email-jpuhlman@mvista.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] Add args.force to localargs before do_add_layer
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
X-List-Received-Date: Wed, 04 Oct 2017 16:43:59 -0000

From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>

Adding layer "meta-signing-key" to conf/bblayers.conf
Traceback (most recent call last):
  File "/local/build/project/build/poky/bitbake/bin/bitbake-layers",
line 103, in <module>
    ret = main()
  File "/local/build/project/build/poky/bitbake/bin/bitbake-layers",
line 96, in main
    return args.func(args)
  File
"/local/build/project/build/poky/bitbake/lib/bblayers/layerindex.py",
line 250, in do_layerindex_fetch
    self.do_add_layer(localargs)
  File
"/local/build/project/build/poky/bitbake/lib/bblayers/action.py", line
44, in do_add_layer
    if not (args.force or notadded):
AttributeError: 'Namespace' object has no attribute 'force'
---
 lib/bblayers/layerindex.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 506c110..9af385d 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -247,6 +247,7 @@ class LayerIndexPlugin(ActionPlugin):
                         logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % name)
                     localargs = argparse.Namespace()
                     localargs.layerdir = layerdir
+                    localargs.force = args.force
                     self.do_add_layer(localargs)
                 else:
                     break
-- 
2.6.2


