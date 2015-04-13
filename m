Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A66806E2C3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 08:18:26 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 13 Apr 2015 01:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,568,1422950400"; d="scan'208";a="480145580"
Received: from abonnier-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.24.248])
	by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2015 01:18:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: parmeshwar tak <parmesh.iiit@gmail.com>
Date: Mon, 13 Apr 2015 09:18:23 +0100
Message-ID: <2860644.gqf1mWsvVV@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.18.9-200.fc21.x86_64; KDE/4.14.6; x86_64; ; )
In-Reply-To: <CACBNtJZdWOa1nC9ObOyzrXmhLBgpT-qYaWqTqHdhBWdP56bBGA@mail.gmail.com>
References: <CACBNtJZdWOa1nC9ObOyzrXmhLBgpT-qYaWqTqHdhBWdP56bBGA@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Want to fetch only files which are having ".new" or ".replace" extention to the ${WORKDIR}.
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
X-List-Received-Date: Mon, 13 Apr 2015 08:18:27 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 09 April 2015 17:55:38 parmeshwar tak wrote:
> I have a simple problem, any one can answer.
> I have a repo "rdk\build_script", and branch ="xyz".
> I need to write a bbappend where the path "patches/Refsw" has some
> files with ".new" and ".replace" extention.
> 
> I want to fetch only files which are having ".new" or ".replace"
> extention to the ${WORKDIR}.

There is no build-in support for this - you'll need to write additional code 
(in the form of python code in a do_unpack_append, or an additional function.)

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

