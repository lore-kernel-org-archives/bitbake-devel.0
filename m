Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <james.limbouris@gmail.com>) id 1Qs0d1-0006Oh-3O
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 00:54:59 +0200
Received: by wwe32 with SMTP id 32so2840607wwe.24
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=ferJ4wwvKC/AptVABBqRnLLYP1v5iM6QeJjefgkikQc=;
	b=t3NGOeBn0zLe4FXHfn8TySMvmN4PN8Erjw7PbMKswXHvOzz9jUYRVYBf+e/m2M4KOr
	obykOF4JfVlBlnwf0cXq1nstGZYmW4mvSVU+64c8Y+MiABVVDfV48xML7Ge0b7mGbyrL
	fzd1BuHJWBg1aow49GkoaDtgzCAFcr6u/rhLU=
MIME-Version: 1.0
Received: by 10.216.120.147 with SMTP id p19mr3412719weh.75.1313189425926;
	Fri, 12 Aug 2011 15:50:25 -0700 (PDT)
Received: by 10.216.23.11 with HTTP; Fri, 12 Aug 2011 15:50:25 -0700 (PDT)
Date: Sat, 13 Aug 2011 06:50:25 +0800
Message-ID: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
From: James Limbouris <james.limbouris@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Conditional assignment broken
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
X-List-Received-Date: Fri, 12 Aug 2011 22:54:59 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

 Commit 21c21fcc5871e81d8d497b6baed605cdd74c4571 breaks conditional assignment
 in all conf files. Previously, the environment was copied from a
cleaned up os environment.
 After the commit, a pristine environment is available in
data['_data'], and will be copied to
 data[] on conditional assignment, defying BB_ENV_EXTRAWHITE.
Variables not conditionally
 assigned will still be available from data['_data'], also in defiance
of BB_ENV_EXTRAWHITE.

 To verify, simply:

 export RANDOMENV=42
 bitbake -e | grep RANDOMENV

 James


