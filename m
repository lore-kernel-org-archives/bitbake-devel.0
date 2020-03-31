Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.75])
 by mx.groups.io with SMTP id smtpd.web10.7707.1585657651090017091
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2020 05:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=Q6N8WIRX;
 spf=pass (domain: windriver.com, ip: 40.107.237.75, mailfrom: konrad.scherer@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BflLfmFe8yvWYnFVgBaoEmmUUAJaOlw0T4I7duy0SZo6UE4F4rUsP2EhghZ1cTKn2+hB5yD9+CxrFwbTrxGX78vnt4PigcZAfpDA3/MJ02sBGVwBv9IzVRJiVTYmp1JWbG6T/75ON/npixdhzcmg8NclStiqSaDnNGDCwv4gQYc7WuJZBdJHMApfRR+9Ow1ZRBPMNySQdH08X6j7XZV7eofciGq3zUI8e6VLhMYCVrJhJvw670pSQGrFGImIzw/4kjT7rRhTnHrqcExjnUjKXItz2UKmlY7ZEtTDTP2C7SzIgv2BL8cS1aLpHF2i47937JhiRbCs9W6V0MAQ69m0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQUIWjHyLcmw+PZRd15gcW9nI6lPuNxDJzE2juIo/tg=;
 b=OxUj/tIF2RY3vLh7J7A2Jn0sR1bEoRiyF0Zg2qCQdU/Xy35qoOCxepxvN6DinhEEn/Ek7kvvgT7OU6fgVkLea0NqEfZP/3bCyc4kLUSlsUfrWcdRQ7J1m2Z/MSrCen1a8NSvakHQlnPsY1z8s/KZn7UCH+Jk6ZS5yJApqswrfrlq6ag0ryYWWzj1Zwk2+u0jhc1VPj6UHJH9o0m8jPDPcpiMlQLUGEouEK/+OO54Lw4keGs7WGMtUYlufBsw8hSAoLM4CHyRKeuv3YHmSxiByMVzS2EFG8KvA4nprMLNVn8hHm3403tt/3dVp5fOR5eJ/BISaF2mTwbLsnrLGgGKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQUIWjHyLcmw+PZRd15gcW9nI6lPuNxDJzE2juIo/tg=;
 b=Q6N8WIRXbN2AOC4k6TC22wmIDaP4q4E5C99nnOAGNJa3okisesnxcwKaTgRse/NGz8+qCk8JOuH+OTkIPUQpH7QqqzTaASqR7dboqzSPaoU6/LxAU11VJSBE/WtvlYxxEdRdC6yzjgPiy4fgVd5cU7pHvW64FNTOWtLxuQCLAdg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Konrad.Scherer@windriver.com; 
Received: from BN8PR11MB3601.namprd11.prod.outlook.com (2603:10b6:408:84::23)
 by BN8PR11MB3571.namprd11.prod.outlook.com (2603:10b6:408:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 12:27:29 +0000
Received: from BN8PR11MB3601.namprd11.prod.outlook.com
 ([fe80::1bb:6d72:f6c4:2a4b]) by BN8PR11MB3601.namprd11.prod.outlook.com
 ([fe80::1bb:6d72:f6c4:2a4b%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 12:27:29 +0000
To: bitbake-devel@lists.openembedded.org
From: "Konrad Scherer" <Konrad.Scherer@windriver.com>
Subject: Layerindex broken by recent change to bitbake tinfoil
Message-ID: <0675cf46-fd67-9b01-4c77-521099191339@windriver.com>
Date: Tue, 31 Mar 2020 08:27:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To BN8PR11MB3601.namprd11.prod.outlook.com
 (2603:10b6:408:84::23)
Return-Path: Konrad.Scherer@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.12] (173.206.104.57) by YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Tue, 31 Mar 2020 12:27:29 +0000
X-Originating-IP: [173.206.104.57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5132b3b5-5da9-4def-2455-08d7d56ee0f8
X-MS-TrafficTypeDiagnostic: BN8PR11MB3571:
X-Microsoft-Antispam-PRVS: 
	<BN8PR11MB35719F79FB4BD65AEC200EFB90C80@BN8PR11MB3571.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3601.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(396003)(39850400004)(346002)(136003)(366004)(26005)(6916009)(16526019)(52116002)(186003)(31696002)(4744005)(5660300002)(86362001)(31686004)(66946007)(956004)(478600001)(66476007)(66556008)(2906002)(81156014)(8676002)(966005)(316002)(36756003)(8936002)(6486002)(16576012)(2616005)(81166006);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Btb9heY7IyULy9SxyuI+BRXi0RdDUz6AKBQFwV6iqdpc13pH6FTNVdQ/S35W3qtzLtKAiDC5wlAN6Zp7fcXub+z6Spr6+eCdhNMAJ4gyHciBYSAm6GgKz64uAwcM9CQyBZTD3W45clnbz35/CYQrM5bdXp6tFHPPLIbFwMY6xdJAKMgL0gTMEUsmg0kUcBs75YDS8uYrUrQGRZLTvhj8gH98UtsCr9lN/KePNIYJy3kpMFkzkgV028AdMABYKg/KQHMSJjv8kxokKmw5JnH+MHTnJUYIXeCt51rNPd95d86vIIzLx+2b4Wpj6uC2Sy2/MzvQrHsbDnPqzC9Q4bh5dnxB6I24QM9FP3dofidbmkLzzUyjh/oVION2AjH3TNbAYOT9BOMtL6EeEcfZibkLWTyCHe6YmJXv9voWYw2GS+QZwtJrsVdLrQlglXS6UriqQUEsh0YK1iyMw0ZUxYRmCkM1n2GLAssUhkC7A1Ny/xWF2wvNj8A7CQkSCeEHazpSCigGAif87FAdlYqEqD9y0Q==
X-MS-Exchange-AntiSpam-MessageData: 
	33o4bTRarvc6pW+cBF2TNrn4g9nzBrBOEdge6Q2qlxMuP50St0z32HZkNjKu6VocHXDAmJFPECeB/RpXN7qTtQ2JCnIEe/y4pfEYLp3fQCf3dI0e7obmFwH9KxNSwu9zD6qOuEbrRG+XncSypgPIJw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5132b3b5-5da9-4def-2455-08d7d56ee0f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 12:27:29.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBVcTicL8GFTOX6kQqIeDBz2JnD1flXhHn7KiEDFFfLTpzkYfUSm59cbAofk+Nhem0LDtCQHSOYzhazed+Ke9F8wnxIdPKCZZ3Qd8m9Mm6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3571
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello,

The following commit to bitbake breaks recipe parsing in the layerindex:

commit f2341dc46b6abfc08a4d01c7abdd3d4630577999
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Mar 23 12:30:04 2020 +0000

     tinfoil: Drop parse_recipe_file custom datastore support

The layerindex uses the tinfoil.parse_recipe_file call to build its database:

https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/tree/layerindex/update_layer.py#n105

now fails with the following error message:

parse_recipe_file() got an unexpected keyword argument 'config_data'

When I remove the config_data argument from the layerindex code the parsing continues, but I don't 
know either code base well enough to determine if this is the correct solution. How best to resolve 
this problem?

Thank you!

-- 
Konrad Scherer, MTS, Linux Products Group, Wind River
