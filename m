Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id E4C6C602D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 11:38:41 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 04 Feb 2016 03:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,395,1449561600"; 
	d="scan'208,217";a="876848555"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 04 Feb 2016 03:38:42 -0800
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 76D446A4002;
	Thu,  4 Feb 2016 04:26:34 -0800 (PST)
Date: Thu, 4 Feb 2016 11:29:07 +0200
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20160204092907.GA21754@linux.intel.com>
Reply-To: ed.bartosh@linux.intel.com
References: <1454577980-21630-1-git-send-email-ed.bartosh@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1454577980-21630-1-git-send-email-ed.bartosh@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [PATCH] toaster: reinstate ID on edit columns button
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
X-List-Received-Date: Thu, 04 Feb 2016 11:38:43 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looks good to me.
Sent upstream.

On Thu, Feb 04, 2016 at 11:26:20AM +0200, Ed Bartosh wrote:
> From: Elliot Smith <elliot.smith@intel.com>
> 
> The ID was omitted from the "edit columns" button on the
> "projects", "all builds" and "project builds" tables when they
> were converted to ToasterTable. This caused the QA tests to fail.
> 
> Reinstate the ID so the tests can identify the "edit columns" button
> correctly.
> 
> [YOCTO #9051]
> 
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/toaster/toastergui/templates/toastertable.html | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/toaster/toastergui/templates/toastertable.html b/bitbake/lib/toaster/toastergui/templates/toastertable.html
> index f0a3aed..9099b30 100644
> --- a/bitbake/lib/toaster/toastergui/templates/toastertable.html
> +++ b/bitbake/lib/toaster/toastergui/templates/toastertable.html
> @@ -57,7 +57,7 @@
>  
>        <div class="pull-right">
>          <div class="btn-group">
> -          <button class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
> +          <button id="edit-columns-button" class="btn dropdown-toggle" data-toggle="dropdown">Edit columns
>              <span class="caret"></span>
>            </button>
>            <ul class="dropdown-menu editcol">
> -- 
> 2.1.4
> 

-- 
--
Regards,
Ed

