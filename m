Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.124])
 by mx.groups.io with SMTP id smtpd.web08.10616.1604047953510382431
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2020 01:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=L+VYed1D;
 spf=pass (domain: prevas.dk, ip: 40.107.15.124, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdvykia9rEPpRi8pbSotJ0ZbbmWQpmmtAXoCrT454iqKtw/DT/Jg8clfqAdG2L/WaoHKlr2tynOT3N/FFRFM/WR3G8buFQcxAhSG40Y+MJLao1wF8PoJZI30gOom8tc4nbM7GOlOEdPOMKeZL8uuM6yMf4/bvdYKNJpT281jfn8wZ4I4dzAOvCqfpp4X6egO3AcIYW0kYW66vH0AebZwj7W6iJBRHMSxu53megsOkh/jA1S7gJYgcjsD76IxwjFCYX8y4bCYapUIqJmxdeEgMh59uFl8oj+nO0OMxodHBwUG63XjLT6YQjfsqy+l+CcQdS1Djl7ILmK9+ToTqvzTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE0sS9mGe1dTJ7QP5lVgxLjiJpVaNSlSmTzMNpOTu1I=;
 b=QwGgdbJ1X/gKJ1sT6wF4k9X1Bi2/y1HY0OVjFQzk35r1qelDpgW9cjWJKI+YXr6i7wZYsu8moSsuiigR34bsN5amdQdOQNZWkylpTTywZyxxtkMZ0nc3f04pU6WiX1kxLlqtO6unSB55mKURqdQI5el9GAmuaV/vxUkM7i3TeM/vVUCbP1lorITa+xSO1tqVr/r/OFTJtIlBoiw+FY8cCFbMoNSaBDX0vXoHRnVRfIWyPVl/w9Ru37m+/OYo2VjjeMA5XxDcz1UIGmS0xDWtXBVRv1i0hl7qja5i2c8CSEaTUizTC7/GgL2ZlipRaPvNOpjlEitbevE/raA8gQDMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE0sS9mGe1dTJ7QP5lVgxLjiJpVaNSlSmTzMNpOTu1I=;
 b=L+VYed1DGqDdGX+FIQgI+WrsWRElwZxRIgn5iCGjUpgJ08mpphbP7HHVtPH7QATbrPmbsIGA2h2Oj/TyAN+RJPVA5e2scZYqEI9lTlojBOeei9NEZA7l4U61YoiiiC0tMR0bbFNuUT8S8cHnx9mjoSERPYRU4/KRFNGsOUtQDvo=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 08:52:29 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3499.024; Fri, 30 Oct 2020
 08:52:29 +0000
Subject: Re: [bitbake-devel] [PATCH v2] fetch: git: add reference parameter
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
 <1640541B397C8D4C.8847@lists.openembedded.org>
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Message-ID: <f1b06485-fc60-df76-f6c5-7973727f605a@prevas.dk>
Date: Fri, 30 Oct 2020 09:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1640541B397C8D4C.8847@lists.openembedded.org>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM0PR06CA0100.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::41) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR06CA0100.eurprd06.prod.outlook.com (2603:10a6:208:fa::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 08:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26f57d6-ae6c-4d5c-f966-08d87cb121f6
X-MS-TrafficTypeDiagnostic: AM9PR10MB4117:
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB41175BF6D6AD71A3FC40107A93150@AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HmaF1saX6B7nwAh3AGI3c189E3ix7Gf0VJ0MHxvT8/I0orzu+KJfYo3dcMoatxqlbtBPtbtX1FioWJ2Kd7ZTB/wQZE+fjAte/AaJy4M48lmwXeZGUWEY/sz8ceNmtGsz8yTxyJ+BI4hpDaWbzTbKAhqyP9vpzKPLyNeRn21Pm/uYthockdGrvAEilHGKLDQBZP4sgACy2gZx4+Hl3q5pY8vk/Y0gB+P6+y4YQN7XsQBQIA/TiDl+r1nTdJHfftsz8SkSEW2brVuVEPxV6JkEomdIADwJ8uLZA8+3upNk3WJPsJzJPdP6J2n7AHKEqwQYVjmAITngaVfOdqkYWkUfC4A8PssELY3HZc1tCUOZsRMjKV4zKUG/GVOjwWcoMecC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(39840400004)(346002)(136003)(396003)(16526019)(52116002)(86362001)(26005)(4326008)(31696002)(956004)(8976002)(2616005)(6916009)(6486002)(186003)(31686004)(83380400001)(44832011)(478600001)(8936002)(316002)(4744005)(16576012)(66556008)(8676002)(2906002)(66946007)(66476007)(36756003)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	9Pm7sbzg2Q3R92YNaz5hrIX9Eltwebjs6ztlaqTtKzFCkhijXMSAcuS91+dYZC3AKOg4XYt4QdJ77oFSSKrVc/mOYrqmVlD7WgSwPFPugc8jGw7NKPpvLZgkZzQDERo6O3wFY+NraHcU9JUL20ZCn48qwMvpw3P4m20d4rZU7Nyp7vzqL6gUJWFHg+Z36Xj/4Xa4BWb+CeX/f7Aj01WuKXwzqAU/jBVlFvytpJN4eVt9KoIG7Li0A39A5zQxZOWhCOfDCNbON76Igf2BbZlyPDHAczagUpcwxR/lBFuBAuYoDWe7ARSMCrEkT1Hu1aG5hz9TJNeVEdGB8fbC19SXX3oWhwlwTh0xUSxIjkfVl+uKp5farKF/OK6DzbieL3WIrHYh0I1najsodenQHGhYA1xVwGnYfxfmkfvitYCWP2+jB2rleLgnnfctn0yee3XEAVVn+c16grpg6GLc8oezK4y5q17Hbi7wW36BBlWolZ7ioA1Kh60TnWhWu5iGMHXQiIfj9vnU6Hz+6uPtQvv9vWKa+PgjI1hjY7PFXnUncwyu10H+WJ7ckBBwpMCOZlRYyNl7vMSFrpVSpsrgdE4TFtRsnsjp/0yBYkJN0iX4WEKIjSC8BIVpoGc64AuyfQWfJJbcdCjfHPUiMpOVcUNomQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f26f57d6-ae6c-4d5c-f966-08d87cb121f6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 08:52:29.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m5qYxTEwpt6qIiiTg7g6EBvRwOOWjvBoO1M1hVbanBUxlQCT1x2jXQBR3PKK2uWxRagTl6mA2LFQIgckOuNnZB7KWUYUknZhXpBgzLk0o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4117
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 22/10/2020 15.38, Rasmus Villemoes via lists.openembedded.org wrote:
> The --reference(-if-able) option to git clone can significantly speed
> up the initial do_fetch if one is able to point git at a local
> repository containing a large number of the objects that would
> otherwise need to be downloaded.
> 
> Allow the developer to define a directory BBFETCH_GIT_REFERENCEDIR,
> subdirectories of which can be used as keys for the new reference=
> parameter to git SRC_URIs. 

Hi Richard,

Is there anything I can do to help move this forward?

Rasmus
