Return-Path: <boucman2@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id 2B429607A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 10:56:09 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id x83so2077256wma.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=pcZS64vQKonDfuVEhWFOPN2DGYJTKxuPhy9bbbOtpBE=;
	b=ePEowyfiX5xFmDvdCeM4Qa43CajAJY41+Sd/15ilpp0RAikjAi5loGQgPR31c7h78G
	bd2DwfvBmT1Py0nBWHiU2G+72zb4ZThEs0OHDPc364qsRRZPm4gWuwnBmxJxt7UkNjH0
	nJl5ScUO3o8+V9kd+U3WtlDP8CmoVrTyl2BmwuyIGYYTehGuXtW8BaUSd0kYP/1xW3I+
	Ie73FCYy29mq5b7FOkKOWyJLDlG2God9A9IaH4owvz2Ycw+eyE+9ER2xT4ExvmTvtlKc
	y1KD5Os0Ov2R0t07fQcLvCKTBRZcvU/+6ejQ+NCZh1OoOyq1qmRH0Fx3VenCaSGa3r6y
	uotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=pcZS64vQKonDfuVEhWFOPN2DGYJTKxuPhy9bbbOtpBE=;
	b=Zq2pJQBnluOV9c1y9snOCqOjkJtwCN2s4yhDHQvOWPUMN9hGQTb5VdVleZYqqRSIXi
	WR6cdQGbadV363kxaB+AkdqVowLslUkvDKGR22GpG+09Wtcek2VzxQ6FythdrD26vkDA
	UvDvabIFmBcgr4vRN4kfeZLH/MGEheJzM6XEJ/3UKxot7VGPZEX9UyEtQzzQh3PLZKKC
	2jo+le80jDccV+y1yjg6Mb7bswqJnydfdkcsfIeQ76MtRDurPNryWPlMrfIQm9q2oZCT
	VIPidLeK27jGfItWAFYPCDDmKeK4AJAvCtUwiRX/kuygf99FhEyzsvoWeG6FY+fFRBee
	Pnuw==
X-Gm-Message-State: ALyK8tIMQyJzvSTFgECdla81dgJmD6lbKI6rRqa50kIAkf8RFXlOSz4ifWEYgDyFcGlu8Q==
X-Received: by 10.28.167.80 with SMTP id q77mr17559760wme.62.1469098570021;
	Thu, 21 Jul 2016 03:56:10 -0700 (PDT)
Received: from localhost.localdomain (229.29.205.77.rev.sfr.net.
	[77.205.29.229]) by smtp.gmail.com with ESMTPSA id
	d80sm3058052wmd.14.2016.07.21.03.56.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Jul 2016 03:56:08 -0700 (PDT)
Sender: jeremy rosen <boucman2@gmail.com>
From: "=?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?=" <jeremy.rosen@enst-bretagne.fr>
X-Google-Original-From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?=
	<jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 12:55:37 +0200
Message-Id: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Jul 2016 14:29:05 +0000
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
Subject: [PATCH 0/1] Add a syntax to clear variables and flags from a conf file
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
X-List-Received-Date: Thu, 21 Jul 2016 10:56:10 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Rosen <jeremy.rosen@openwide.fr>

While working on a Yocto project I had a need to reactivate a task that was
disabled (do_fetch[noexec]="1") Currently, bitbake does not check the value
of the noexec flag but only if the flag is set. The only way to unset a flag
is to use an inline python syntax like the one below

python () {
   d.delVarFlag("do_fetch","noexec")
}

Using inline python to do something as simple as clearing a flag sounded too
complicated to me so I added a new keyword "unset" to bitbake with the
following syntax :

unset VAR

will call d.delVar("VAR")

unset VAR[flag]

will call d.delVarFlag("VAR","flag")

Documentation has been updated accordingly


Jérémy Rosen (1):
  add a syntax to clear variable

 .../bitbake-user-manual-metadata.xml               | 17 +++++++++++
 bitbake/lib/bb/parse/ast.py                        | 33 ++++++++++++++++++++++
 bitbake/lib/bb/parse/parse_py/ConfHandler.py       | 12 ++++++++
 3 files changed, 62 insertions(+)

-- 
2.8.1


