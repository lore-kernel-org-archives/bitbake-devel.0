Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 44E6774AF1
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Sep 2018 12:15:55 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w84CFsYh027713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 4 Sep 2018 13:15:56 +0100
Message-ID: <2ba43936a9d6d2a1baac49c419cdc5c86cbbdbf1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 04 Sep 2018 13:15:54 +0100
In-Reply-To: <192b8cc1-4ea9-1cd7-5a3f-f4c150868a0e@siemens.com>
References: <192b8cc1-4ea9-1cd7-5a3f-f4c150868a0e@siemens.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] process: Flush server stdout/stderr before reporting failure
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
X-List-Received-Date: Tue, 04 Sep 2018 12:15:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2018-09-02 at 10:43 +0200, Jan Kiszka wrote:
> We need to print exceptions and flush output channels before telling
> the
> client that the server failed. Otherwise the daemon log file may
> still
> be empty when the client opens it for printing.
> 
> This fixes error reporting when the output is redirected to a pipe,
> e.g.
> "bitbake target | cat" with a syntax error in a recipes or config
> file.
> That's specifically annoying when bitbake is under the control of a
> frontend process such as kas.

Hi,

Could you check if this was already fixed by:

http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=cbe2d3cb0af6c7a5cd368e7dc489960a13648bd0

?

I really want to get these flushes as close to the source of the
problems as we can.

Cheers,

Richard

