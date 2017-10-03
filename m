Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id 662406E671
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Oct 2017 09:39:53 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id l196so3287077lfl.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Oct 2017 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=pUiDMikNKLT+25HQ1ILpjxy3Z4CkpLigHCAeTXZUYak=;
	b=nYozUsKIRDpxZQjO/is22HnElEJO0b/FYIDY1/KNHDEA+FB8qPOAZNx8R+oKuBwY/3
	4+aKqEOMKaQcQYXsvFEdPlhJXKNrf8cuW1qsIq8mW0wawW+LVTI7Ef9VSFgZk28rTd3q
	IU1Ai4E3oSKfk5bTs19qGwlh6sGzfr7BBGdpcBAoQsFfg4R6himkCuV+aPdxLu9QiLF2
	8LxFceTC1ZuoAQs0qlcVEeNWlj3MRsqf2Sm22tm22F5242vdwkbEPwZidXpUlfH2QMt0
	mkFW6VQi2XNLZzZCq0ULQ4qYEJbVqYYpNWpEJJ8rRJYSfLbDj2A6jaFbdABk9I3W7pJ1
	mNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=pUiDMikNKLT+25HQ1ILpjxy3Z4CkpLigHCAeTXZUYak=;
	b=KY/MJhlq8AfpQ6qr8AOBgrby66l+ovRzGlTf1FQwcpy1l9zxCRRKiOw++L14ZFtsbe
	/pIj0261eExmnU45UxvWCLK3VnZA5JZrJZqYBH1Wnp/f3OKpa5odSoOj4CMpfSlLVv7F
	Pv2azRi26GKzEvme0bFeTqaK36ycc3m6PQsEzGrvtWyqgOTd3nbAkBiDcfKG/Pcxn1k4
	kmk6hKfgqbGvVyNivo3797+LXlad3OZbn4u1lLE5sOnxkXnfjNOVms1Pvy1hADuOiA5j
	o0VJ4JI2ssTvBdwVaGwWFG8tIhvTzAM16AwjSVy7ICZeu0S6Lk8b5/+6hMQKC5c8qsC5
	IKqQ==
X-Gm-Message-State: AHPjjUggKV1q6JGXhByG75aWzl2cO5OBruYnMefNiMFGYlVyYyMDofpF
	U5huAIdNFb68B8q0dM0Mrhh/qaSD
X-Google-Smtp-Source: AOwi7QCgILU/Rn/xmvuprmqSO11uOvJkp2FGDWhtDdhbOHqQx+MdVNcVJY8BJfPLiwgW0TxCu20RfQ==
X-Received: by 10.46.33.163 with SMTP id h35mr8527239lji.152.1507023594688;
	Tue, 03 Oct 2017 02:39:54 -0700 (PDT)
Received: from neopili.qtec.com
	(cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
	by smtp.gmail.com with ESMTPSA id
	g132sm1955929lfe.13.2017.10.03.02.39.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Oct 2017 02:39:53 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Martin Jansa <Martin.Jansa@gmail.com>, Ross Burton <ross.burton@intel.com>
Date: Tue,  3 Oct 2017 11:39:51 +0200
Message-Id: <20171003093951.30014-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.14.2
X-Mailman-Approved-At: Fri, 06 Oct 2017 08:51:14 +0000
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] bitbake.conf: Add sdl-config to HOSTTOOLS
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
X-List-Received-Date: Tue, 03 Oct 2017 09:39:54 -0000

Without this patch bitbake cannot find sdl-config

ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
Following is the list of potential problems / advisories:

libsdl-native is set to be ASSUME_PROVIDED but sdl-config can't be found in PATH. Please either install it, or configure qemu not to require sdl.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 meta/conf/bitbake.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index 2dac3a1481eb..ebd758d1d904 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -471,6 +471,9 @@ HOSTTOOLS += " \
 # Tools needed to run testimage runtime image testing
 HOSTTOOLS += "ip ping ps scp ssh stty"
 
+# Link to sdl-config if using host SDL
+HOSTTOOLS += "${@bb.utils.contains('ASSUME_PROVIDED', 'libsdl-native', 'sdl-config', '', d)}"
+
 # Link to these if present
 HOSTTOOLS_NONFATAL += "aws ccache gcc-ar gpg ld.bfd ld.gold nc sftp socat sudo"
 
-- 
2.14.2


