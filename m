Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1U3bmc-0007BS-BX
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Feb 2013 01:25:38 +0100
Received: by mail-pa0-f48.google.com with SMTP id hz10so1770210pad.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2013 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:resent-from:resent-date:resent-message-id:resent-to:date
	:from:cc:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=9vsQglQ4DA09jy5/RhPRwfngfmh19JmT0dWrXPfcXI0=;
	b=mA0xZQcbHf5e48eOdCKSde2ZgLwwfY3e0aqLNX++AkF9CScimSe2yFRW9Do6Wc8WBG
	7aVZMs5zufMJxZeP91o8hG2cceWTGtwePoot0jlBUFQjScc4ZUMLsV5ViAA78ezFobYk
	NeVc8IXr3hBAoVnSAAmTnJGUMQSxENwg6ykJo5YIs2XQv2h/KwELMQii3HX0wTzyWtDm
	nLvkfiTsZM0gE3lDJ1oIeRN0vVSAvS7NwhvoesaTNK8TOCF23Z1tyGKlJpOYzqFs4viy
	+IFjLTH86LsgxPbNOOJZdPn2Mx+TU736V49cRJisQORdZZMsURADC0NNUsMH/z3EUdH2
	L/YQ==
X-Received: by 10.66.89.138 with SMTP id bo10mr43901886pab.32.1360193297705;
	Wed, 06 Feb 2013 15:28:17 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id t6sm41053278paz.11.2013.02.06.15.28.15
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Wed, 06 Feb 2013 15:28:16 -0800 (PST)
Resent-From: Martin Jansa <Martin.Jansa@gmail.com>
Resent-Date: Thu, 7 Feb 2013 00:28:09 +0100
Resent-Message-ID: <20130206232809.GF3271@jama>
Resent-To: bitbake-devel@lists.openembedded.org
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id k7sm27665479paz.13.2013.02.06.15.18.36
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Wed, 06 Feb 2013 15:18:37 -0800 (PST)
Date: Thu, 7 Feb 2013 00:18:30 +0100
From: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Message-ID: <20130206231830.GE3271@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: bitbake cache broken today
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
X-List-Received-Date: Fri, 08 Feb 2013 00:25:39 -0000
X-Groupsio-MsgNum: 3235
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5iEYumb6eglF6CEb"
Content-Disposition: inline

--5iEYumb6eglF6CEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Very likely by this patch:
cooker/utils: Drop custom 'interactive' variables list and store environment in BB_ORIGENV instead
http://git.openembedded.org/bitbake/commit/?id=0a99563a4ea270594fd9a61da46f9387fb79dc66

$ bitbake -p > test1.cache
$ bitbake -p > test2.cache

$ grep "^Parsing of" test*
test1.cache:Parsing of 773 .bb files complete (0 cached, 773 parsed). 1079 targets, 43 skipped, 0 masked, 0 errors.
test2.cache:Parsing of 773 .bb files complete (0 cached, 773 parsed). 1079 targets, 43 skipped, 0 masked, 0 errors.

--- test1.cache 2013-02-07 00:15:50.930868804 +0100
+++ test2.cache 2013-02-07 00:14:32.044865976 +0100
@@ -4804,7 +4804,7 @@
     else:
         oe.path.remove(stfile + ".*")
         oe.path.remove(stfile + "_setscene" + ".*")
-', 'PREFERRED_PROVIDER_virtual/arm-oe-linux-gnueabi-compilerlibs': 'gcc-runtime', 'BB_ORIGENV': <bb.data_smart.DataSmart object at 0x19d6150>, 'BUILDHISTORY_DIR_IMAGE': '${BUILDHISTORY_DIR}/images/${MACHINE_ARCH}/${TCLIBC}/${IMAGE_BASENAME}', 'preferred_ml_updates': 'def preferred_ml_updates(d):
+', 'PREFERRED_PROVIDER_virtual/arm-oe-linux-gnueabi-compilerlibs': 'gcc-runtime', 'BB_ORIGENV': <bb.data_smart.DataSmart object at 0x35e9590>, 'BUILDHISTORY_DIR_IMAGE': '${BUILDHISTORY_DIR}/images/${MACHINE_ARCH}/${TCLIBC}/${IMAGE_BASENAME}', 'preferred_ml_updates': 'def preferred_ml_updates(d):
     # If any PREFERRED_PROVIDER or PREFERRED_VERSIONS are set,
     # we need to mirror these variables in the multilib case;
     # likewise the PNBLACKLIST flags.


--5iEYumb6eglF6CEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlES5MYACgkQN1Ujt2V2gBxFRwCghe9cnw6ACqgH/z2CdKVUJsk/
TVwAn0Z6OEOumkE1EIGzhjev5TkcX8nQ
=sF4n
-----END PGP SIGNATURE-----

--5iEYumb6eglF6CEb--
