import React, {useState, useEffect} from 'react';

import axios from 'axios';
import moment from 'moment';
import 'moment/locale/id'; 

const useApi = () => {
    let typingTimer = null;
    let [data, setData] = useState([]);
    let [paged, setPaged] = useState(1);
    let [search, setSearch] = useState('');
    let [loading, setLoading] = useState(false);
    let [loadingMore, setLoadingMore] = useState(false);
    moment.locale('id');

    useEffect(() => {
        fetchData();
    }, []);

    useEffect(() => {
        fetchSearchData();
    }, [search]);

    useEffect(() => {
        let sizedMobile = 0;
        if( isMobile.any() ) sizedMobile = 10;
        window.onscroll = function(ev) {
            if ((window.innerHeight + window.scrollY) >= (document.body.scrollHeight - sizedMobile)) {
                setLoading(true);
                fetchMoreData();
            }
        };
    }, [data]);

    const fetchData = async props => {
        setLoading(true);
        await axios(`https://youlead.id/wp-json/barav/v1/search?paged=1&s=${search}`)
        .then(item => {
            setData([...data, ...item.data]);
            setLoading(false);
        });
    }

    const fetchMoreData = async props => {
        await axios(`https://youlead.id/wp-json/barav/v1/search?paged=${paged + 1}&s=${search}`)
        .then(item => {
            if(item.data.length > 0){
                setData([...data, ...item.data]);
                setLoading(false);
                setPaged(paged + 1);
            }
        });
    }

    const fetchSearchData = async props => {
        setLoading(true);
        await axios(`https://youlead.id/wp-json/barav/v1/search?paged=1&s=${search}`)
        .then(item => {
            setData(item.data);
            setLoading(false);
        });
    }

    const searchPost = e => {
        let search = e.target.value;

        clearTimeout(typingTimer);
        typingTimer = setTimeout(() => {
            setSearch(search);
        }, 800);
    }

    const fetchImage = item => {
        let image = item.featured_image.large;

        if(image != ''){
            return image;
        }else{
            return `${process.env.PUBLIC_URL}/notfound.jpg`;
        }
    }

    const limitTitle = item => {
        let title = item.title.substr(0, 50);
        let titleMobile = item.title.substr(0, 20);

        return {
            web: title + '...',
            mobile: titleMobile + '...',
        }
    }

    const limitContent = item => {
        let contentWeb      = item.content.substr(0, 100);
        let contentMobile   = item.content.substr(0, 29);

        let resultWeb = strip(contentWeb);
        let resultMobile = strip(contentMobile);         

        return {
            web: resultWeb + '...',
            mobile: resultMobile +'...',
        }
    }

    const fetchTime = item => {
        let time = moment(item.date_gmt).format('DD MMMM YYYY hh:mm:ss');
        return time;
    }

    const strip = (html) => {
        var doc = new DOMParser().parseFromString(html, 'text/html');
        return doc.body.textContent || "";
    }

    const isMobile = {
        Android: function() {
            return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function() {
            return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function() {
            return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function() {
            return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function() {
            return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
        },
        any: function() {
            return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
        }
    };

    return {
        data: data,
        loading : loading,
        fetchData: fetchData,
        fetchTime: fetchTime,
        searchPost: searchPost,
        limitTitle: limitTitle,
        fetchImage: fetchImage,
        limitContent: limitContent,
        fetchMoreData: fetchMoreData,
    }
}

export default useApi;