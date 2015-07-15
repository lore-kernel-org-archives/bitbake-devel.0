Return-Path: <armccurdy@gmail.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
	[209.85.218.41])
	by mail.openembedded.org (Postfix) with ESMTP id 298D575ED4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jul 2015 09:07:30 +0000 (UTC)
Received: by oibn4 with SMTP id n4so24146601oib.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jul 2015 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=NqwknI4I9OWQ8dgY5msj+kcRHXTuF85VJFX6WX+QC4c=;
	b=Y89cAGfU4cP5EQtNOYaNItHM3VxqA/aOuPH4V8OH2JpniYK4Pt3nSyYgUgwEZhTa+7
	FItdENAtWXl6/coK0nB1iZJig6Ju0DnqJnUYB9XDE1grsdBgaeyT2sagKXaEbSmWCaVi
	Yc08KqAg6q6BPG9i+lCBvxXGzVL4U8DOEMgl9NwUzQprJXhloOFnBvU8G0+1RKz+Pn+3
	LeZAxF6kOKt09Q+BHDFRnG2aPRUn7mHib7FHR/oS8xdArrSQwoMMEoCCE0P3Byy5khuI
	BmAI/er6X5LYIwkdQZVgPmd9sNIpVNgZOG1Rge8a0nmLWTalqj+XYgk+ogsbA7Iur2Y9
	zZRA==
MIME-Version: 1.0
X-Received: by 10.202.81.3 with SMTP id f3mr2637532oib.29.1436951251001; Wed,
	15 Jul 2015 02:07:31 -0700 (PDT)
Received: by 10.202.64.130 with HTTP; Wed, 15 Jul 2015 02:07:30 -0700 (PDT)
Date: Wed, 15 Jul 2015 02:07:30 -0700
Message-ID: <CAJ86T=UGtMmyg8U64v7Q00=Hdb7g_qQAYbUYC-mpnK-ErMKGEQ@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: exec_func_shell shell script exit
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
X-List-Received-Date: Wed, 15 Jul 2015 09:07:32 -0000
Content-Type: text/plain; charset=UTF-8

exec_func_shell currently adds this to the end of every shell script:

  ret=$?
  trap '' 0
  exit $?

Should that be:

  ret=$?
  trap '' 0
  exit $ret

?

