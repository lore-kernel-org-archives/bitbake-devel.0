Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0DB6377D76
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491553973; x=1523089973;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=QpBDjHsvATMgiUuV8yPPhU5fthjNaDML6dn1Tt6nybw=;
	b=skT5M7x35QfyVprXNT/R1eHQ+ByG566/xHakl9clVO+A1v8ACkNkTc1G
	CT4f1AmMsZtgLpcmZIOQIyDLeDZ49w==;
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Apr 2017 01:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,164,1488873600"; d="scan'208";a="84613487"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.179])
	by orsmga005.jf.intel.com with ESMTP; 07 Apr 2017 01:32:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Date: Fri, 07 Apr 2017 20:32:48 +1200
Message-ID: <51436031.kQGnlfrvNB@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <16393836.ok1xE2uA39@peggleto-mobl.ger.corp.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<1491551779.10884.69.camel@intel.com>
	<16393836.ok1xE2uA39@peggleto-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Fri, 07 Apr 2017 08:32:52 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 7 April 2017 8:29:18 PM NZST Paul Eggleton wrote:
> Hi Patrick,
> 
> On Friday, 7 April 2017 7:56:19 PM NZST Patrick Ohly wrote:
> > On Fri, 2017-04-07 at 09:52 +1200, Paul Eggleton wrote:
> > > As part of an effort to add task signature recording and comparison to
> > > buildhistory in OE, I went digging into bitbake-diffsigs and the code
> > > that supports it and discovered that unfortunately it had a number of
> > > bugs - in particular the -t option despite being around for a while and
> > > having numerous band-aids applied in the past still wasn't really
> > > working properly.
> > 
> > I'm not sure whether it is working now, even with your changes. My
> > test, using poky master and your bitbake branch:
> > 
> > 1. bitbake -c cleansstate m4
> > 2. bitbake m4
> > 3. patch m4:
> > diff --git a/meta/recipes-devtools/m4/m4_1.4.18.bb
> > b/meta/recipes-devtools/m4/m4_1.4.18.bb
> > index b12c0adf3ad..0a8e9c10778 100644
> > --- a/meta/recipes-devtools/m4/m4_1.4.18.bb
> > +++ b/meta/recipes-devtools/m4/m4_1.4.18.bb
> > @@ -1,3 +1,7 @@
> > 
> >  require m4-${PV}.inc
> > 
> > +do_install_append () {
> > +    echo hello world
> > +}
> > +
> > 
> >  BBCLASSEXTEND = "nativesdk"
> > 
> > 4. bitbake m4
> > 5. bitbake-diffsigs -t m4 do_build
> > => ERROR: No sigdata files found matching m4 do_build
> > 
> > There is one file for do_build in tmp/stamps/i586-poky-linux/m4 and
> > several for do_install:
> > 
> > $ ls -l tmp/stamps/i586-poky-linux/m4/*do_build*
> > tmp/stamps/i586-poky-linux/m4/*do_install* -rw-r--r-- 1 pohly pohly     0
> > Apr  7 09:53
> > tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_build.aa7d33bbb2dfef67ef3ca1b5d
> > 3
> > f2cde1 -rw-r--r-- 1 pohly pohly     0 Apr  7 09:53
> > tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.a0954ae23d8da50c4af22f7
> > 1
> > 9255411f -rw-r--r-- 1 pohly pohly 20573 Apr  7 09:52
> > tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.sigdata.464e707d80ec982
> > f
> > b5b0c50a6526f05a -rw-r--r-- 1 pohly pohly 19610 Apr  7 09:53
> > tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.sigdata.a0954ae23d8da50
> > c
> > 4af22f719255411f
> > 
> > 
> > bitbake-diffsigs does not fail for do_install, but does not print
> > anything either (= no output at all from "bitbake-diffsigs -t m4
> > do_install").
> > 
> > Hmm, does it pick the right files to compare?
> > 
> > $ bitbake-diffsigs -d -t m4 do_install
> > DEBUG: Signature file (previous):
> > /fast/build/poky/x86/sstate-cache/a0/sstate:m4:i586-poky-linux:1.4.18:r0:i
> > 5
> > 86:3:a0954ae23d8da50c4af22f719255411f_install.tgz.siginfo DEBUG: Signature
> > file (latest):
> > /fast/build/poky/x86/tmp/stamps/i586-poky-linux/m4/1.4.18-r0.do_install.si
> > g
> > data.a0954ae23d8da50c4af22f719255411f
> > 
> > Am I using the tool incorrectly or are my expectations wrong?
> > 
> > My expectation was that "bitbake-diffsigs -t m4 do_build" would tell me
> > that m4 was rebuilt because some tasks that it depends on changed, and
> > then I would drill down to those tasks, eventually arriving at
> > do_install.
> 
> Hmm, something has gone wrong here because this is the exact scenario it's
> supposed to handle. In my similar tests it did work, so I'm not sure why it
> didn't work in this case - I'll have to give it a try here.

I send and then I immediately realised what might be wrong - you said you're 
using poky master which implies that you haven't also applied the patches for 
lib/oe/sstatesig.py that I sent to the OE-Core list today. If you haven't, try 
doing that, it should fix the problem.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

