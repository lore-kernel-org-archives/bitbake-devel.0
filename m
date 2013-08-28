Return-Path: <raj.khem@gmail.com>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
	[209.85.160.41])
	by mail.openembedded.org (Postfix) with ESMTP id 2A3CC6BBCE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2013 07:40:01 +0000 (UTC)
Received: by mail-pb0-f41.google.com with SMTP id rp2so5947832pbb.28
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2013 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=DAde0SoywaMV7Hxp/ZVAckUBtW3RA40qfIrhh5r7Ius=;
	b=LT7pMvmQUppZqPVVtUjmtlc4PHXEGNO/njqkE84+eWg+T/yBZ+nF4SqkqVOWUy2s7R
	Tuxt7WqFw6bwBDMUpSZfbF9YcZPWQbkc1j0hpnZu/pQnFwKjJczkfCCCDkTwUI882WgO
	vZ/1TDEDlTnPMAZJVlC8SgYM3uK6N3Npufjnfb3alWvDF2/ovM3hnMH43VmvkIpbGvls
	4Mm9s3SloPru9PjRjoJ/j5x8KyM9NM6N62o9C4P8Iscz7P8AjhTkXNU/NB8VpqlkF1fQ
	T606sfsAQ4VZGpwNv+eOEfYOOPH2L98y4GQD0wduLIGYtv5swhszjvox85sw+NfvKB5W
	QzIQ==
X-Received: by 10.68.191.36 with SMTP id gv4mr13466225pbc.167.1377675601594;
	Wed, 28 Aug 2013 00:40:01 -0700 (PDT)
Received: from kraj-sslvpn-nc.jnpr.net (natint3.juniper.net. [66.129.224.36])
	by mx.google.com with ESMTPSA id
	nj9sm29507664pbc.13.1969.12.31.16.00.00
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 28 Aug 2013 00:40:00 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <1377656455-5850-1-git-send-email-jason.wessel@windriver.com>
Date: Wed, 28 Aug 2013 00:40:02 -0700
Message-Id: <8B10DEC4-A37A-4316-806B-647C30283100@gmail.com>
References: <1377656455-5850-1-git-send-email-jason.wessel@windriver.com>
To: Jason Wessel <jason.wessel@windriver.com>
X-Mailer: Apple Mail (2.1508)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] serv.py: Fix regression from 972bc43e6d5b
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
X-List-Received-Date: Wed, 28 Aug 2013 07:40:02 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


On Aug 27, 2013, at 7:20 PM, Jason Wessel <jason.wessel@windriver.com> =
wrote:

> commit 972bc43e6d5b1207b944b3baa8f9805adb35dda7 (serv.py: Fix hang
> when spawned dynamically with bitbake) introduced a regression,
> because the wrong patch was submitted.  The syntax was incorrect in
> the original patch.  The logger iterator must be used with a call to
> getLogger().

I was seeing errors like

NOTE: Started PRServer with DBfile: =
/builds1/angstrom/cache/prserv.sqlite3, IP: 127.0.0.1, PORT: 55073, PID: =
20469
ERROR: PRservice 127.0.0.1:55073 not available

Which I narrowed down to 972bc43e6d5b as well.

This patch fixes it.

>=20
> [YOCTO #5059]
>=20
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> ---
> lib/prserv/serv.py |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 781f054..6d0c718 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -146,7 +146,7 @@ class PRServer(SimpleXMLRPCServer):
>         # Clear out all log handlers prior to the fork() to avoid =
calling
>         # event handlers not part of the PRserver
>         for logger_iter in logging.Logger.manager.loggerDict.keys():
> -            logger_iter.handlers =3D []
> +            logging.getLogger(logger_iter).handlers =3D []
>=20
>         # Ensure logging makes it to the logfile
>         streamhandler =3D logging.StreamHandler()
> --=20
> 1.7.9.5
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


