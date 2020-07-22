import React from 'react';

import './style.css';

import useApi from '../../hooks/api';

import Card from '../../materials/Card';

import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
    paper: {
        margin: 'auto',
        maxWidth: 500,
        padding: theme.spacing(2),
        backgroundColor: '#FFFFF',
    },
  }));

const styled = {
    header: {
        height: 80,
        paddingTop: 5,
        textAlign: 'center',
    },
    content: {
        height: 700,
    }
}

const Post = props => {
    const classes = useStyles();
    const {
        data, fetchContent, fetchImage, 
        fetchTime, fetchTitle,
    } = useApi();

    return (
        <Grid container spacing={1}>
            <Grid item md={3} xs={12}>

            </Grid>
            <Grid item md={6} xs={12}>
                <Paper>
                <div style={styled.header}>
                    header
                </div>
                <div style={styled.content}>
                    {data && 
                        data.map((item, index) => {
                            let time    = fetchTime(item);
                            let title   = fetchTitle(item);
                            let image   = fetchImage(item);
                            let content = fetchContent(item);

                            return <Card
                                key={index} 
                                time={time}
                                image={image}
                                title={title} 
                                content={content}
                            />    
                        })
                    }
                </div>
                </Paper>
            </Grid>
        </Grid>
    )
}

export default Post;