Return-Path: <ross.burton@intel.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 84FD46C670
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 15:01:26 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id l9so12616182wrt.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=+b/Ifje3mNAKawodsLlt6x1QSOrFkpii140Fx6/dnDM=;
	b=JV0olLfVlblVszSclBMiGuTZmSH7LiG3G+2xd+yr3acrcMMQ0iRHtii3LH1Y8uS4G6
	9y8yw0w/aZfnzkXlYpHpUKXMYuETDAxn5Vua+0zw+M/Aou1voIIPBNKT4qCb1hXBjptc
	ELNQNNMfMpCmreMdwAjQRj9Zy80gMv7YNfDDKCEztHE6iHhWnpVIqg4Bkmny4yZtG/lG
	SMYvoZvlKiSomcAjwsP0x0AU+mde9NH6Ckls02A0hOIK95D8h8hSTsTVtkbLuGfmwBJ1
	gwFyoppz8dckWxWDKlZ15hRVf4RcNU4VQ+q8yCX/7dcjCp+F41bsxa+vTmbvrbgf75TL
	qn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=+b/Ifje3mNAKawodsLlt6x1QSOrFkpii140Fx6/dnDM=;
	b=Y1p2Q7RGf/77HMx/w9qPpq3MR3EhcJdOVnyGqdnAQDpamv1dOrQIiZUdsYopzpSRsV
	04D25vdrMIRVhDNXSFROpsdgl7WvFyrtqVXFdYZNhX5E+Fa73gg5BEn/7OeyslhN2ldc
	ENH2eaHQmEDderQTpHvW3RCtv/lPDXiM7+Vry3VsI2ak+loIGSk6OoYllmeN5IZYrAlq
	fyyCPaxzSwgHtvbmCItHZxQhQLo7DZayIEwsqKZb3OQirqmcqlZTHtKKSuf+UBPTaRWN
	jKty3y/GPktTLoMOZ+lNe8GUdw6GhNTta2+PA7Dk8i/nuZSLph3StPUjT82rTmUiJLWs
	iFBw==
X-Gm-Message-State: AA+aEWY8zc+mQRwfe2FyzZ++NDKAH/WHRqZeFfIERUJdAcaZLWyKj6sH
	jDce2buzqg/GLQJaHzUeNY8wcyorvHk=
X-Google-Smtp-Source: AFSGD/W6jRtHjMeE1tmZx1+urfCVIZvpQcQxEOvNeo9IDGaDwrt0uCCp47RDtTxAJs3aFejgw3cZGA==
X-Received: by 2002:adf:fcc1:: with SMTP id f1mr13792068wrs.296.1542985287007; 
	Fri, 23 Nov 2018 07:01:27 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	n15sm25204205wrt.21.2018.11.23.07.01.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Nov 2018 07:01:26 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Nov 2018 15:01:22 +0000
Message-Id: <20181123150122.23585-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181123150122.23585-1-ross.burton@intel.com>
References: <20181123150122.23585-1-ross.burton@intel.com>
Subject: [PATCH 2/2] fetch: don't use shell=True when listing ar files
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
X-List-Received-Date: Fri, 23 Nov 2018 15:01:26 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 572b71a9655..8d05f0c3d82 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1469,7 +1469,7 @@ class FetchMethod(object):
                 else:
                     cmd = 'rpm2cpio.sh %s | cpio -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
-                output = subprocess.check_output('ar -t %s' % file, preexec_fn=subprocess_setup, shell=True)
+                output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup)
                 datafile = None
                 if output:
                     for line in output.decode().splitlines():
-- 
2.11.0


