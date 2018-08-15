Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 94B9079094
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 08:37:35 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w7F8bYui002552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 15 Aug 2018 09:37:35 +0100
Message-ID: <6f9b4884358d08f5e4e35ebd9b683218ef0e40f0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andreas =?ISO-8859-1?Q?M=FCller?= <schnitzeltony@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 15 Aug 2018 09:37:34 +0100
In-Reply-To: <20180813210445.32496-2-schnitzeltony@gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-2-schnitzeltony@gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 1/2] runqueue: Move decision if a task can be started to one common place
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
X-List-Received-Date: Wed, 15 Aug 2018 08:37:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2018-08-13 at 23:04 +0200, Andreas Müller wrote:
> Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
> ---
>  lib/bb/runqueue.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

I don't think it makes sense to take 2/2 as the gains don't seem worth
the complexity. 1/2 is a good improvement to the code and makes
experimentation easier so I'll likely take that though.

Cheers,

Richard

