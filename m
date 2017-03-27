Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3EB66607A5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490598166; x=1522134166;
	h=from:to:subject:date:message-id:in-reply-to:references:
	mime-version:content-transfer-encoding;
	bh=8PJBA4zcA2xSBe70glDEYigw75FmbIobER2Di8n8910=;
	b=rIZu8/Q0goGchinoDzs/WXwvycB+kWQHSI0ubnOTK3oArcLW49NVnkzu
	pKwDeJohpeS4edEUgdzrtw8E8BOutQ==;
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Mar 2017 00:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,229,1486454400"; d="scan'208";a="1147315485"
Received: from tienhauh-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.171.185])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2017 00:02:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2017 20:02:41 +1300
Message-ID: <2804620.WKlMG7RfZ2@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <9f62b06d0f7c0df4f3ca91b24af2c0d791d16d7c.1490573768.git.paul.eggleton@linux.intel.com>
References: <cover.1490573768.git.paul.eggleton@linux.intel.com>
	<9f62b06d0f7c0df4f3ca91b24af2c0d791d16d7c.1490573768.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] tinfoil: enable client-side logger handling by default
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
X-List-Received-Date: Mon, 27 Mar 2017 07:02:45 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 27 March 2017 1:17:28 PM NZDT Paul Eggleton wrote:
> If you had a script that uses tinfoil and it failed to connect to the
> BitBake server, you did't see any of the expected messages - this was
> because client-side logging wasn't being handled at all. Since you'll
> almost always want this when using tinfoil, have it use the new
> bb.msg.logger_create() function to enable client-side logging by
> default.

Sigh... this causes a bunch of debug messages from the codeparser to get shown 
when using devtool add. I am still tracking that issue down - perhaps it's 
better than not seeing any messages at all though.

- Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

