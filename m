Return-Path: <stephano.cetola@linux.intel.com>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by mail.openembedded.org (Postfix) with ESMTP id 69DF1788F6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Mar 2018 21:49:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Mar 2018 13:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,447,1515484800"; d="scan'208";a="40676490"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga002.jf.intel.com with ESMTP; 09 Mar 2018 13:49:13 -0800
Received: from scetola-mac01.jf.intel.com (unknown [10.54.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 35CB758046C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Mar 2018 13:49:13 -0800 (PST)
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
From: Stephano Cetola <stephano.cetola@linux.intel.com>
Message-ID: <348fcb7c-d3df-eae8-0787-7238a77ac51f@linux.intel.com>
Date: Fri, 9 Mar 2018 13:49:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
Subject: New Release Number 2.99 in Bugzilla
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
X-List-Received-Date: Fri, 09 Mar 2018 21:49:12 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Please excuse the cross posting here. This information is pertinent to
anyone submitting bugs to the Yocto project Bugzilla, so I want to reach
as large an audience as is appropriate.

The Yocto Project team is moving to a new release planning process and I
want to provide an overview as there will be some things I need from
those of you making changes and adding things to Bugzilla.

Overview:
We are moving to a “Pull” process for planning rather than a “Push”
process.  What this means is that we will start with an empty 2.6
release bucket and pull bugs and enhancements in that map to our top
priorities rather than push things out of a giant bucket.  We are hoping
this will help us start 2.6 with a very clear idea as to what we will
focus on and be much less overwhelming than pushing a giant snowball
through each release.

How does this effect you?
If you are pushing bugs/enhancements to the next release or adding new
bugs/enhancements for the next release you need to be aware of the
following:

-We have a M+ Future status that holds items that are important and need
to be addressed soon.  This bucket is pretty big.
-We have moved all 2.6 features and bugs to a 2.99 release.  This bucket
is a temporary hold for the items that didn’t make it into 2.5 and are
at the very top of our list for review to pull in.  We don’t want them
to get lost in the M+ Future bucket.  Once 2.6 planning is complete,
this 2.99 bucket will be empty and removed.
-If you are adding new bugs and enhancements that you believe should be
slotted for 2.6, please enter them as 2.99.
-If you are pushing anything from 2.5 to 2.6, please enter it as 2.99.

Please let me know if you have any questions about this.

Thanks,
Stephano

