Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gopikrishnans@pec.edu>) id 1Sh2Gk-0004yn-73
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jun 2012 19:31:10 +0200
Received: by pbbrq2 with SMTP id rq2so9479404pbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jun 2012 10:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=9RqeUrxkx2auc1QXUpt+IJ4JwI+vRZ0pi44RKudbB8s=;
	b=lbG8CD/HqWik5OtSg8yPYgyJuWoZjEMYRzoqrcaj3V7phk7hIbAY29GhOFMLe6aK93
	yygkjnFlqnUL+aRouseR6JdQFVeT0Ly31x+MwVD00GYooncEd5u0hzkm+NCfhM1WDzFB
	Fs9j23AEVTbg9jpT1zEchv6H6TLKPjslznf+6uxQViqWcSxrEoCfDrQEpkaniVPcJaui
	T6+5i9fU7Q14BvOLn29OEe7MqFO4IcP/OH2nhFzYKW6luK9Onjv9iyXLqIcY2KMdxHMv
	aJCuSd2eD+/1CynLxbqJWYdsV9KKRIyCZIst5uU7zg1PnDQ/cforIiEhCQiCXFA3A8X9
	ZN/w==
Received: by 10.68.193.226 with SMTP id hr2mr66169121pbc.155.1340126425492;
	Tue, 19 Jun 2012 10:20:25 -0700 (PDT)
Received: from [117.231.10.69] ([117.231.10.69])
	by mx.google.com with ESMTPS id hb5sm28531419pbc.58.2012.06.19.10.20.22
	(version=SSLv3 cipher=OTHER); Tue, 19 Jun 2012 10:20:24 -0700 (PDT)
Message-ID: <4FE0B4D8.4020704@pec.edu>
Date: Tue, 19 Jun 2012 22:50:24 +0530
From: Gopi - College <gopikrishnans@pec.edu>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<4FE065F9.6010300@windriver.com>
In-Reply-To: <4FE065F9.6010300@windriver.com>
X-Gm-Message-State: ALoCoQkKxT+P5Jx7gbwIqgCSd5eoeVL/jcFZa/M8WpbYS1t7efjb5Mdfe8vtQKWmE8rlfvZpGS37
Subject: Re: [PATCH 0/2] Signature-based rebuild improvements
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 19 Jun 2012 17:31:10 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
        I want to install some light weight web server with PHP on my 
board. Does openembedded have any repository with webserver and PHP? Or 
which webserver will be nest suitable for freescale p2020 board.

Reg,
Gopi


