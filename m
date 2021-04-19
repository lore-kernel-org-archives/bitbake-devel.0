Received: from linuxplesk15.openhost.net.nz (linuxplesk15.openhost.net.nz [119.47.118.83])
 by mx.groups.io with SMTP id smtpd.web11.1511.1618868187230930300
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Apr 2021 14:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 119.47.118.83, mailfrom: bluelightning@bluelightning.org)
Received: from linc.localnet (unknown [151.210.226.152])
	by linuxplesk15.openhost.net.nz (Postfix) with ESMTPSA id 55C83A2F40;
	Tue, 20 Apr 2021 09:36:23 +1200 (NZST)
Authentication-Results: linuxplesk15.openhost.net.nz;
	spf=pass (sender IP is 151.210.226.152) smtp.mailfrom=bluelightning@bluelightning.org smtp.helo=linc.localnet
Received-SPF: pass (linuxplesk15.openhost.net.nz: connection is authenticated)
From: "Paul Eggleton" <bluelightning@bluelightning.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] bin/bitbake-getvar: Add a new command to query a variable value (with history)
Date: Tue, 20 Apr 2021 09:36:22 +1200
Message-ID: <7360338.lvqk35OSZv@linc>
In-Reply-To: <20210416171126.1373752-2-richard.purdie@linuxfoundation.org>
References: <20210416171126.1373752-1-richard.purdie@linuxfoundation.org>
	<20210416171126.1373752-2-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
X-PPP-Message-ID: <20210419213623.3979763.68753@localhost6.localdomain6>
X-PPP-Vhost: softec.co.nz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 17 April 2021 05:11:26 NZST Richard Purdie wrote:
> We've talked about having this for long enough. Add a command which queries
> a single variable value with history. This saves "bitbake -e | grep" and
> avoids the various pitfalls that has.
> 
> It also provides a neat example of using tinfoil to make such a query.
> 
> Parameters to limit the output to just the value, to limit to a variable
> flag and to not expand the output are provided.
> 
> [YOCTO #10748]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

This is great, I have wanted to see this for quite a while! About the only 
feedback would be to add a short option for  --value, though I wonder if -v is 
the best option to choose or not given that it's typically short for "verbose" 
with most tools.

Cheers
Paul




