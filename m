Return-Path: <maxin.john@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 183B57899F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Mar 2018 15:44:09 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Mar 2018 07:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800"; d="scan'208";a="24631202"
Received: from mbabyjoh-desk.fi.intel.com (HELO
	mbabyjoh-desk.ger.corp.intel.com) ([10.237.72.84])
	by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2018 07:44:09 -0800
Date: Fri, 2 Mar 2018 17:47:14 +0200
From: "Maxin B. John" <maxin.john@intel.com>
To: Parthiban Nallathambi <pn@denx.de>
Message-ID: <20180302154714.GA32533@mbabyjoh-desk.ger.corp.intel.com>
References: <1c9ddeef-cae3-20b7-964b-768f999c7803@denx.de>
	<20180302122913.GA15235@mbabyjoh-desk.ger.corp.intel.com>
	<d5285955-4e4c-ea92-015f-ecd17b8a63ea@denx.de>
MIME-Version: 1.0
In-Reply-To: <d5285955-4e4c-ea92-015f-ecd17b8a63ea@denx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: Yocto: Add custom user to custom group in bitbake recipe
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
X-List-Received-Date: Fri, 02 Mar 2018 15:44:10 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Parthiban,

On Fri, Mar 02, 2018 at 01:58:35PM +0100, Parthiban Nallathambi wrote:
> Hi Maxim,
> 
> space.bb --> chromium recipe in https://github.com/OSSystems/meta-browser/tree/master/recipes-browser/chromium
> 
> app.bb --> http-server.bb attached
> 
> I have created a group "www" in http-server_0.10.0.bb and trying to add
> "chromium" user to this group in chromium-x11_%.bbappend.

As useradd documentation says,
for -G " The group name must exist. A group number must refer to an already existing group."

So, the "GROUPADD_PARAM_${PN} = "www", should be in 
chromium-x11_%.bbappend before we use:

USERADD_PARAM_${PN} = "-d ${localstatedir}/lib/chromium -s /bin/false -G tty,video,input,www,www-data -U chromium

> But the useradd command is failed: group 'www' does not exit.
> 
> 
> On 03/02/2018 01:29 PM, Maxin B. John wrote:
<snip>

Best Regards,
Maxin

