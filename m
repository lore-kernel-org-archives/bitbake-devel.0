Return-Path: <maxin.john@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D08C5789A6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Mar 2018 12:26:09 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Mar 2018 04:26:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800"; d="scan'208";a="21539701"
Received: from mbabyjoh-desk.fi.intel.com (HELO
	mbabyjoh-desk.ger.corp.intel.com) ([10.237.72.84])
	by orsmga007.jf.intel.com with ESMTP; 02 Mar 2018 04:26:09 -0800
Date: Fri, 2 Mar 2018 14:29:14 +0200
From: "Maxin B. John" <maxin.john@intel.com>
To: Parthiban Nallathambi <pn@denx.de>
Message-ID: <20180302122913.GA15235@mbabyjoh-desk.ger.corp.intel.com>
References: <1c9ddeef-cae3-20b7-964b-768f999c7803@denx.de>
MIME-Version: 1.0
In-Reply-To: <1c9ddeef-cae3-20b7-964b-768f999c7803@denx.de>
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
X-List-Received-Date: Fri, 02 Mar 2018 12:26:09 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Parthiban,

On Fri, Mar 02, 2018 at 12:29:25PM +0100, Parthiban Nallathambi wrote:
> Hello All,
> 
> I have created a custom group e.g "grp1" in my application recipe say
> "app.bb".
> 
> GROUPADD_PARAM_${PN} = "grp1"
> 
> I am trying add my custom user e.g: "user1" to this group "grp1" in
> "space.bb".
> 
> USERADD_PARAM_${PN} = "-d ${localstatedir}/lib/space/ -s /bin/false -G grp1
> -U user1"
> 
> The useradd command failed saying the "useradd: group 'grp1' does not
> exist". I have also tried adding DEPENDS_${PN} = "app" in space.bb, but it
> doesn't help.
>
> How can I add my custom user to my custom group in bitbake recipe?

Please share your sample recipes here. It will be helpful to debug the problem.

> Question in Stackoverflow: https://stackoverflow.com/questions/49068076/yocto-add-custom-user-to-custom-group
> 
> -- 
> Thanks,
> Parthiban Nallathambi

Best Regards,
Maxin

