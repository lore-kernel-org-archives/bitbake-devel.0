Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 533FA71144
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 21:09:20 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id l15so36622325wiw.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 13:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to
	:message-id; bh=7gftdQENpTTKhgrrrI1ktb9r0AmQzYz7sMPEamSo9Eo=;
	b=Ts4u1efdktymxVkaAHNrsGOArIP2sflVQbBNWsPK521o5rsSEsg/pdI0QCG85RctU9
	6RAbZkyNQ88rg51PUMi3UJK4lLDbj6iA692y5QN/dteI7XtyRL+EAqqPWj+u1bFlmjCj
	FMr6YzWEvU/xiXo+lcDA4fmGtoCVZvtQ3o6LUp9W6B20QmzEPGmz+E5VtRhtskKApCWh
	J1p+C9sVAlQnPMLfKyOXadzW2axRD7ce09qDW1BRBICoWzIv6XK+h8eaX04svJn9ogc0
	j0TX9iWomw4VtNgik17146PYnik+KW5MF7nFN2wyKGGWDLAUNfikrJ3mvpsQrKPJLAho
	xx8w==
X-Received: by 10.194.57.43 with SMTP id f11mr7066241wjq.6.1421960960737;
	Thu, 22 Jan 2015 13:09:20 -0800 (PST)
Received: from 046207038239.atmpu0026.highway.a1.net
	(046207038239.atmpu0026.highway.a1.net. [46.207.38.239])
	by mx.google.com with ESMTPSA id dc1sm4535908wib.18.2015.01.22.13.09.19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Jan 2015 13:09:20 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <77A8CA6E-0A1D-4E38-B4C0-98EAA4711824@gmail.com>
References: <cover.1421895046.git.Chong.Lu@windriver.com>
	<a04905e3262a83cb0c00fcfc9609077200af2da2.1421895046.git.Chong.Lu@windriver.com>
	<77A8CA6E-0A1D-4E38-B4C0-98EAA4711824@gmail.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Thu, 22 Jan 2015 22:09:13 +0100
To: Chong Lu <Chong.Lu@windriver.com>, bitbake-devel@lists.openembedded.org,
	paul.eggleton@linux.intel.com
Message-ID: <C0BC539D-E32D-478B-8E62-2EE9EEB70C55@gmail.com>
Subject: Re: [PATCH V2 2/2] bitbake-layers: add a ability to	query layer dependencies from layer index
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
X-List-Received-Date: Thu, 22 Jan 2015 21:09:21 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On January 22, 2015 6:05:36 PM GMT+01:00, Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> wrote:
>> (host, port) = parsedurl.netloc.split(":")
>
>Please rsplit, don't add more of these bugs..
>http://lists.openembedded.org/pipermail/bitbake-devel/2013-June/003533.html

Something like

def splitport(host):
   """splitport('host:port') --> 'host', 'port'.""" 
   if host[0] == '[':
     # Escaped IPv6 
     host, port = host[1:].split(']', 1)
     if ':' in port:
       port = port.rsplit(':', 1)[1]
     else:
       port = None
   else:
      if host.count(':') == 1:
        # IPv4
        host, port = host.split(':')
      else:
        # unescaped IPv6 hosts with port are a no go
        port = None
   return (host, None if port is None else int(port)) 

And fixup all callers.
I don't have a real keyboard at hand ATM..

Thanks,


