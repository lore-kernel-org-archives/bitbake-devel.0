Received: from linuxplesk15.openhost.net.nz (linuxplesk15.openhost.net.nz [119.47.118.83])
 by mx.groups.io with SMTP id smtpd.web10.4144.1618957847490754276
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Apr 2021 15:30:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 119.47.118.83, mailfrom: bluelightning@bluelightning.org)
Received: from linc.localnet (unknown [151.210.226.152])
	by linuxplesk15.openhost.net.nz (Postfix) with ESMTPSA id EE295A0EF0;
	Wed, 21 Apr 2021 10:30:44 +1200 (NZST)
Authentication-Results: linuxplesk15.openhost.net.nz;
	spf=pass (sender IP is 151.210.226.152) smtp.mailfrom=bluelightning@bluelightning.org smtp.helo=linc.localnet
Received-SPF: pass (linuxplesk15.openhost.net.nz: connection is authenticated)
From: "Paul Eggleton" <bluelightning@bluelightning.org>
To: Diego Sueiro <diego.sueiro@arm.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake: layerindex: Add --fetchdir parameter to layerindex-fetch
Date: Wed, 21 Apr 2021 10:30:44 +1200
Message-ID: <2573830.ElGaqSPkdT@linc>
In-Reply-To: <6b47f8915980672ba16ca0a7b40b46084457df56.1618588951.git.diego.sueiro@arm.com>
References: <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
	<6b47f8915980672ba16ca0a7b40b46084457df56.1618588951.git.diego.sueiro@arm.com>
MIME-Version: 1.0
X-PPP-Message-ID: <20210420223045.2623937.90426@localhost6.localdomain6>
X-PPP-Vhost: softec.co.nz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Diego

On Saturday, 17 April 2021 04:07:11 NZST Diego Sueiro wrote:
> Introduce --fetchdir parameter to layerindex-fetch enabling users to choose
> parser_layerindex_fetch.add_argument('-f', '--fetchdir', help='directory to fetch the layers')

For the help text I would suggest "directory to fetch the layer(s) into (will be created if it does not exist)", but otherwise looks good.

Cheers
Paul




