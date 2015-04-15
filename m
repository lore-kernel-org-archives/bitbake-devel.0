Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9DD3765C9C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 11:48:24 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 15 Apr 2015 04:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,581,1422950400"; d="scan'208";a="556405470"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 15 Apr 2015 04:48:25 -0700
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 27ABE6A408F;
	Wed, 15 Apr 2015 04:48:00 -0700 (PDT)
Date: Wed, 15 Apr 2015 14:48:19 +0300
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: Christopher Larson <clarson@kergoth.com>
Message-ID: <20150415114819.GA23297@linux.intel.com>
References: <1429044350-19766-1-git-send-email-ed.bartosh@linux.intel.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237988ED7477@ORSMSX101.amr.corp.intel.com>
	<CABcZANnTuVDDisxj3W1EjE_RN3MAaLnk2-9Wm_rcnq4E1jR=ew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZANnTuVDDisxj3W1EjE_RN3MAaLnk2-9Wm_rcnq4E1jR=ew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Allow environment variables and ~ in bbconf paths
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: ed.bartosh@linux.intel.com
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 15 Apr 2015 11:48:26 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2015 at 02:33:41PM -0700, Christopher Larson wrote:
> On Tue, Apr 14, 2015 at 2:19 PM, Rifenbark, Scott M <
> scott.m.rifenbark@intel.com> wrote:
> 
> > Ed,
> >
> > This worked for me.... Thanks.
> >
> > Scott
> >
> > >-----Original Message-----
> > >From: Ed Bartosh [mailto:ed.bartosh@linux.intel.com]
> > >Sent: Tuesday, April 14, 2015 1:46 PM
> > >To: bitbake-devel@lists.openembedded.org
> > >Cc: Rifenbark, Scott M; Ed Bartosh
> > >Subject: [PATCH] Allow environment variables and ~ in bbconf paths
> > >
> > >This should allow to use ~, $HOME and other environment variables in
> > bbconf
> > >paths.
> > >
> > >Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> >
> 
> We already have a mechanism by which environment variables flow into the
> metadata. Is there something wrong with using BB_ENV_EXTRAWHITE to use
> ${HOME} in this context?

Thank you for pointing out to this. However, I couldn't make this mechanism
to work for bbconf. I tried to set BB_PRESERVE_ENV, BB_ENV_WHITELIST and BB_ENV_EXTRAWHITE without any luck.
bitbake still crashes if HOME is used in bbconf.

--
Regards,
Ed

