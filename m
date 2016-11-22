Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id EB3D3606A8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Nov 2016 20:11:48 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 22 Nov 2016 12:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,682,1473145200"; d="scan'208";a="789619319"
Received: from hsu7-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.157.214])
	by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2016 12:11:46 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: sujith h <sujith.h@gmail.com>
Date: Wed, 23 Nov 2016 09:11:43 +1300
Message-ID: <4380989.s9a6u3CJO3@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.7.10-100.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <CADyYWL=Zz0oHNW=gF--i3DD=ZU8ZgVd_K50MC7nwVx0RcHy4Fw@mail.gmail.com>
References: <CADyYWLmiBkOd9xuc2SqfUG3sO6FdLGd9y5=+SNtGCCVC65tZ8w@mail.gmail.com>
	<CADyYWL=Zz0oHNW=gF--i3DD=ZU8ZgVd_K50MC7nwVx0RcHy4Fw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: getAllKeysWithFlags: Issue when returning the dump var
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
X-List-Received-Date: Tue, 22 Nov 2016 20:11:49 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Sujith,

On Tue, 22 Nov 2016 16:20:30 sujith h wrote:
> Finally I found that not all data in my case was
> string/list/tuple/dict/None/int/float. That is those data types which can
> be marshalled: https://docs.python.org/3/library/xmlrpc.client.html. But
> there was a data type :
> v = <subprocess.Popen object at 0x7f56f4964ef0>. So this was causing the

What on earth is a subprocess.Popen object doing in the datastore? Which 
variable / flag is that?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

