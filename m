Received: from mail-vc0-f170.google.com ([209.85.220.170])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <schnitzeltony@googlemail.com>) id 1UDaCc-0002YL-1b
	for bitbake-devel@lists.openembedded.org;
	Thu, 07 Mar 2013 13:45:44 +0100
Received: by mail-vc0-f170.google.com with SMTP id p16so224114vcq.15
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Mar 2013 04:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=r0+/EYwz7tBHXN6cHec25QbuhcqtG4nRnJ5uU5++Ll0=;
	b=HSpPTKkuR2b7xmcjC3V9+JKFw0lRNzcehGoGB7iVEd1N/AbYvsg79O7x7uHv9htQu6
	Iuz2rv/JcWb1teRRNHIgzNYS+o60k67F5/DBtDUzjv3IdLHyZx4s3b2OQ3Glli/OntFI
	U5l6bqrxjLs8rHdd3IX3vocNrCCyf2Jl9wQECIOvzBW9dHTw0VNnLvVhJrP3jfYlMrYD
	EXO0vlhi6F1RFPRRKlGyGAbcaBcJDD0Zv1TNFKbTUdEiTiSllpEcJ/Bo4hJWNG9speV8
	OujizjpdWB4lYQM1Aov35ICG/g0JamUSTfwfrIbDAlJQOClqI657s1VSKCEJxiW3EJqv
	1bKQ==
MIME-Version: 1.0
X-Received: by 10.58.132.170 with SMTP id ov10mr12941042veb.57.1362659349653; 
	Thu, 07 Mar 2013 04:29:09 -0800 (PST)
Received: by 10.52.185.168 with HTTP; Thu, 7 Mar 2013 04:29:09 -0800 (PST)
Date: Thu, 7 Mar 2013 13:29:09 +0100
Message-ID: <CALbNGRQyp3B-r-=ea5a4ojo3u5Vys5G0uiMytzLxWc8QSAtaxw@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Parse error with latest HEAD
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
X-List-Received-Date: Thu, 07 Mar 2013 12:45:44 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

To parse as expected I need to revert the following commits:

commit 32c2d497976a5c6dfa7f25dd2b84f4cd6d0a5b9f
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Wed Mar 6 15:32:35 2013 +0000

    Revert "cooker: parse using bb.compat.Pool"

    Reverting the pool changes, terminate does not work reliably on
    bb.compat.Pool :(

    [YOCTO #3978]

    This reverts commit 8af519a49a3374bd9004864ef31ca8aa328e9f34.

commit f68af40555b6b73345805cfb99ca96e3ce27cb35
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Wed Mar 6 15:31:49 2013 +0000

    Revert "cooker: now that we use a Pool, raise the exceptions"

    Reverting the pool changes, terminate does not work reliably on
    bb.compat.Pool :(

    This reverts commit 9ca8e513dc142dd7aefadeb6db2ccdb00f38b39f.

Otherwise I get at a build from scratch:

ERROR: ExpansionError during parsing
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/systemd-gnome-image.bb:
Failure expanding variable get_split_linguas: ExpansionError: Failure
expanding variable IMAGE_LINGUAS, expression was
${@base_less_or_equal("ROOT_FLASH_SIZE", "16", "", "en-us", d)} which
triggered exception TypeError: float() argument must be a string or a
number
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/console-image.bb
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/systemd-gnome-image.bb
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/hardware-bringup-image.bb
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/xfce-nm-image.bb
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/efl-nodm-image.bb
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/systemd-image.bb
NOTE: Error during finalise of
/home/andreas/data/oe-core/sources/meta-angstrom/recipes-images/angstrom/console-base-image.bb
ERROR: Command execution failed: Exited with 1

AFAICS there are not IMAGE_LINGUAS in the recipes.

Andreas


