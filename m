Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id CFA9F605F1;
	Thu, 29 Jan 2015 17:25:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0THPrI2023577
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 29 Jan 2015 09:25:54 -0800 (PST)
Received: from Marks-MacBook-Pro.local (172.25.36.231) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.174.1; Thu, 29 Jan 2015 09:25:53 -0800
Message-ID: <54CA6D20.4010604@windriver.com>
Date: Thu, 29 Jan 2015 11:25:52 -0600
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1422539142.git.paul.eggleton@linux.intel.com>
	<e1f6bd9ed8e0a1b89277af10e0d9af17ec8efd86.1422539142.git.paul.eggleton@linux.intel.com>
In-Reply-To: <e1f6bd9ed8e0a1b89277af10e0d9af17ec8efd86.1422539142.git.paul.eggleton@linux.intel.com>
Cc: openembedded-core@lists.openembedded.org
Subject: Re: [RFC bitbake][RFC PATCH 1/1] cooker: rework LAYERDEPENDS versioning so that it is actually useful
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
X-List-Received-Date: Thu, 29 Jan 2015 17:26:02 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 1/29/15 7:49 AM, Paul Eggleton wrote:
> We've had versioned dependency support in LAYERDEPENDS for quite a long
> time, but I can say with pretty good certainty that almost nobody has
> used it because it was too strict - the specified version had to exactly
> match the version in your configuration or you would get an error; there
> was no "greater than or equal" option, which is usually what you will
> want given that LAYERVERSION does get bumped.
> 
> However, users mismatching layer branches and then having their builds
> fail later on with some incomprehensible error is still a pretty common
> problem. To address this, I have reworked LAYERDEPENDS version
> specifications to use the more familiar "dependency (>= version)" syntax
> as used with package dependencies, support non-integer versions, and
> clarified the error message a little. If we then take care to bump the
> version on every breaking change, it is at least possible to have layers
> depend on these changes when they update to match; we can now even
> support a major.minor scheme to allow retrospectively adding a version
> limiter to old branches when a new branch is created and yet still allow
> the old branch minor version to be bumped if needed.
> 
> Fixes [YOCTO #5991].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>

I've run into this exact support situation as well.  I think we need to do
something like this >, =, <, etc.. so that we can add the necessary keys to
layers to more clearly indicate what is and isn't supported (combination wise.)

I'm all for this!

--Mark

