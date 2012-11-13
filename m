Received: from smtprelay01.ispgateway.de ([80.67.31.39])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <news@christianvolk.net>) id 1TYF3F-0005Mn-81
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 12:53:09 +0100
Received: from [80.67.16.116] (helo=webmailfront01.ispgateway.de)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <news@christianvolk.net>)
	id 1TYElp-0006Tc-FX for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 12:35:09 +0100
Received: from 62.154.182.130 ([62.154.182.130]) by webmail.df.eu (Horde
	Framework) with HTTP; Tue, 13 Nov 2012 12:35:09 +0100
Date: Tue, 13 Nov 2012 12:35:09 +0100
Message-ID: <20121113123509.Horde.cZcPJLuWis5QojBtb0_w6KA@webmail.df.eu>
From: news@christianvolk.net
To: bitbake-devel@lists.openembedded.org
User-Agent: Internet Messaging Program (IMP) H4 (5.0.19)
MIME-Version: 1.0
X-Df-Sender: bmV3c0BjaHJpc3RpYW52b2xrLm5ldA==
X-Mailman-Approved-At: Tue, 13 Nov 2012 15:27:21 +0100
Subject: BitBake & ClearCase
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
X-List-Received-Date: Tue, 13 Nov 2012 11:53:09 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Content-Disposition: inline

Dear bitbake-developer-community,

I just stumbled across a problem and knows of no other advice than to  
write to you here:

In my company we have to use bitbake in combination with ClearCase (CC).
Bitbake has some problems with the ClearCase-owned files called  
?.copyarea.db?.
Unfortunately, CC adds such a file to each directory which is under  
source-control.
The file is read-only and so the task do_unpack fails with the  
following error message:

cp: cannot create regular file  
`/home/[...]/testability-1.0-r0/./testability_src_gen/.copyarea.db':  
Permission Denied

I did not find a solution, but I still hope that there is a way to  
tell bitbake to exclude files in the source-code directory from  
copying into the work-directory. I?m dreaming about a git-likewise-way  
with the .gitignore file.

Thank you for your help in advance!
Sincerely yours
Christian Volk



