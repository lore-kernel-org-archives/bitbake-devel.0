Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2CFB478FEB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 15:47:48 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w7EFllWm002724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 14 Aug 2018 16:47:49 +0100
Message-ID: <478b7fbd747a9807da31f2f4df69fb1c12ed3799.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 14 Aug 2018 16:47:47 +0100
In-Reply-To: <49400e02-454a-42c6-e11c-0d72f9e191ab@prevas.dk>
References: <20180813180226.18299-1-ross.burton@intel.com>
	<49400e02-454a-42c6-e11c-0d72f9e191ab@prevas.dk>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 1/2] utils/md5_file: don't iterate line-by-line
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
X-List-Received-Date: Tue, 14 Aug 2018 15:47:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-08-14 at 10:33 +0200, Rasmus Villemoes wrote:
> On 2018-08-13 20:02, Ross Burton wrote:
> > Opening a file in binary mode and iterating it seems like the
> > simple solution
> > but will still break on newlines, which for binary files isn't
> > really useful as
> > the size of the chunks could be huge or tiny.
> 
> And what exactly was wrong with
> 
> http://lists.openembedded.org/pipermail/bitbake-devel/2018-July/00940
> 7.html
> http://lists.openembedded.org/pipermail/bitbake-devel/2018-July/00940
> 9.html
> 
> ? I have lots of patches and ideas for performance improvements in
> bitbake, pseudo and other components, but I'm not getting any
> response
> at all, which is rather frustrating.

Sorry, that is my fault, I hadn't gotten around to reviewing/testing
them.

Ross' patch using mmap should be slightly more efficient so I'll likely
go with that but I'd take a patch to sort the other hash functions
(e.g. sha256) out similarly and now I'm much more familiar with the
code and expecting the change, review should be much simpler/faster...

Sorry once again...

Cheers,

Richard

