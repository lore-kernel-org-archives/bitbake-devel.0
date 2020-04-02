Received: from smtpcmd03116.aruba.it (smtpcmd03116.aruba.it [62.149.158.116])
 by mx.groups.io with SMTP id smtpd.web10.9803.1585841657230452110
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Apr 2020 08:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@aruba.it header.s=a1 header.b=jY4pJzwH;
 spf=none, err=permanent DNS error (domain: faresoftware.it, ip: 62.149.158.116, mailfrom: mauro@faresoftware.it)
Received: from [192.168.24.172] ([93.38.119.136])
	by smtpcmd03.ad.aruba.it with bizsmtp
	id MraF2200U2wfazh01raFib; Thu, 02 Apr 2020 17:34:16 +0200
To: bitbake-devel@lists.openembedded.org
From: "Mauro Ziliani" <mauro@faresoftware.it>
Subject: Custom variable value: (OVERRIDES?)
Message-ID: <6bce089d-050d-7c57-15ac-a182b548f694@faresoftware.it>
Date: Thu, 2 Apr 2020 17:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
	t=1585841656; bh=sWXkO0Z/DDTSRKAVa1Ogc/sezrK4ivoYEVfzWkhyMz4=;
	h=To:From:Subject:Date:MIME-Version:Content-Type;
	b=jY4pJzwHSCT1B8FW9GsCvQ622yfyhgn/XpL+uXp63oPR0d+incA0rTVV07KAGos3p
	 nyZw2nt0m0z9EbvAXaToc3PCXBSSQFXz4y6wtFJ4pgteJNLQ2LnOEbGHowwphFbDPO
	 q7m497vhJ3HHvl14TWIw77fdv8LXup6MtenqRNvCeHYa18OGMPZPhI3dwLyUeCg5v8
	 /+IgZgHHy4h3EJdTfARpsUAmieGMF218qyZRetrN6fBp44IDGOS5NRuj0ebb3Kl4th
	 AyuKj14lizlRvu/dHT+kkQ7ctD4h7qbgDYHw/WPeZwueqTGGIOAWUmEHA1xnDBubIQ
	 o9BJuc+nHOHmg==
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it

Hi all.

I don't understand how can I change a the value of a variable inside a 
.bb file

I do this work

if MYVAR is empty I need to install default.txt in /etc

if MYVAR contains "white" i need to install white.txt in /etc


So I extend myreciped.bb with this file


myrecipe.bbappend

MYVAR = "default.txt"

MYVAR_white = "white.txt"


do_install_append() {

     install -m 0755 -d ${D}/etc

     install -m 0644 ${MYVAR}    ${D}/etc/value

}


In conf/local.conf I put

MYVAR_pn-myrecipe = "white"


But nothing works as I expect.

Where is my mistakes?


Best regards,

   MZ

