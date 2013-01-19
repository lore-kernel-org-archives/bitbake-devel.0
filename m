Received: from mail-bk0-f45.google.com ([209.85.214.45])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <yanglei.fage@gmail.com>)
	id 1TwUix-0000k5-D1; Sat, 19 Jan 2013 10:28:29 +0100
Received: by mail-bk0-f45.google.com with SMTP id jk13so2342787bkc.4
	for <multiple recipients>; Sat, 19 Jan 2013 01:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=t2Z45qEG3rs3Y/Vn2mMZY8ywFxwPtV13QWXZwFDWpo8=;
	b=bOdUoDAQVeA5YFFNr75u5vIymBLvM2KksM4y+DWBlXgmDW5xKAa4UQhuoa+/qbx+XR
	eJKHVOvSOFXjuevDO+HD1/YsmKKFEWsMVGwycxcnTn7feUd0MT9vjVydGYY/4Uf03dY6
	l2hhbxu4zj/X8H5WUDmUmg4jL84MyyVsDnArgqNRaP0Vx4lLd9RsyAqYHy4gUr/QHzEW
	tT6Saa8Dp/ijQoCxewkxQmCK0xc+W25zLY/HzUnky6HwtB2sNNLwaRXsJFQVtIuByGsq
	BWp0XTUwktcF9LAYTVq7gCE19rcK9hMRqObKRhfb2MMsZx86LLpCcqqJbCHc0Eo4P4V8
	9o2g==
MIME-Version: 1.0
X-Received: by 10.204.5.145 with SMTP id 17mr3157586bkv.98.1358586781508; Sat,
	19 Jan 2013 01:13:01 -0800 (PST)
Received: by 10.204.11.86 with HTTP; Sat, 19 Jan 2013 01:13:01 -0800 (PST)
Date: Sat, 19 Jan 2013 17:13:01 +0800
Message-ID: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
From: lei yang <yanglei.fage@gmail.com>
To: openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org
Subject: git address in SRC_URI, doesn't works for me
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
X-List-Received-Date: Sat, 19 Jan 2013 09:28:30 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hi experts.

One git address's prefix is "http" --->
http://git.opensvc.com/multipath-tools/.git,

it means

git clone  http://git.opensvc.com/multipath-tools/.git  ---------> works
git clone git://git.opensvc.com/multipath-tools/.git ---------> doesn't work

I tried SRC_URI with below, both failed

SRC_URI = "http://git.opensvc.com/multipath-tools/.git;protocol=git"
it tells
fatal: reference is not a tree: c23c0d33ed98a1dcee40115018b73cb3d4cda8d7


SRC_URI = "git://git.opensvc.com/multipath-tools/.git;protocol=http"
it doe noting,and trying to find COPING,but it doesn't clone it

any help?


Lei


