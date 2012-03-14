Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1S7kEF-00060y-Bu
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 10:10:43 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q2E91vME011730
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 14 Mar 2012 02:01:57 -0700 (PDT)
Received: from [128.224.162.241] (128.224.162.241) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Wed, 14 Mar 2012 02:01:57 -0700
Message-ID: <4F605E85.7070904@windriver.com>
Date: Wed, 14 Mar 2012 17:01:57 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [128.224.162.241]
Cc: Richard Purdie <richard.purdie@intel.com>
Subject: How to identify WORKDIR?
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
X-List-Received-Date: Wed, 14 Mar 2012 09:10:43 -0000
Content-Type: multipart/alternative;
	boundary="------------030604020608070404070009"

--------------030604020608070404070009
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I write a script to clean up WORKDIR that remove the obsoleted packages' 
build directories.
The script accept a argument as BUILDDIR and I use this clause to 
identify the WORKDIR:

      workdir = os.path.join(builddir, 'tmp/work')

Then validate the workdir exists or not. It works for me but hardcode 
here as Richard point out.
So is there  a better way to get the WORKDIR here? Thanks.

Regards,
Kai


--------------030604020608070404070009
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi All,<br>
    <br>
    I write a script to clean up WORKDIR that remove the obsoleted
    packages' build directories. <br>
    The script accept a argument as BUILDDIR and I use this clause to
    identify the WORKDIR:<br>
    <br>
    <big>&nbsp;&nbsp;&nbsp;&nbsp; workdir = os.path.join(builddir, 'tmp/work')<br>
      <br>
      <small>Then validate the workdir exists or not. It works for me
        but</small> </big>hardcode here as Richard point out. <br>
    So is there&nbsp; a better way to get the WORKDIR here? Thanks.<br>
    <br>
    Regards,<br>
    Kai<br>
    <br>
  </body>
</html>

--------------030604020608070404070009--
